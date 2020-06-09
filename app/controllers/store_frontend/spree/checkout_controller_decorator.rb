module StoreFrontend
  module Spree
    module CheckoutControllerDecorator

      def self.prepended(base)
        base.after_action :normalize_addresses, only: [:update,:edit]
        base.before_action :set_addresses, only: [:update,:edit]
      end

      def set_addresses
        return unless params[:order] && params[:state] == 'address'
        if params[:order][:ship_address_id].to_i > 0
          params[:order].delete(:ship_address_attributes)
          ::Spree::Address.find(params[:order][:ship_address_id]).user_id != try_spree_current_user&.id && raise('Frontend address forging')
        else
          params[:order].delete(:ship_address_id)
        end
        if params[:order][:bill_address_id].to_i > 0
          params[:order].delete(:bill_address_attributes)
          ::Spree::Address.find(params[:order][:bill_address_id]).user_id != try_spree_current_user&.id && raise('Frontend address forging')
        else
          params[:order].delete(:bill_address_id)
        end
      end

      def normalize_addresses
        return unless params[:state] == 'address' && @order.bill_address_id && @order.ship_address_id
        # ensure that there is no validation errors and addresses were saved
        return unless @order.bill_address && @order.ship_address
        bill_address = @order.bill_address
        ship_address = @order.ship_address
        if @order.bill_address_id != @order.ship_address_id && bill_address == ship_address
          @order.update_column(:bill_address_id, ship_address.id)
          bill_address.destroy
        elsif params[:save_user_address]
          bill_address.update_attribute(:user_id, try_spree_current_user&.id)
        end
        ship_address.update_attribute(:user_id, try_spree_current_user&.id) if params[:save_user_address]
      end

      def before_address
        headers['Last-Modified'] = Time.now.httpdate
        @order.ship_address ||= ::Spree::Address.new(country: ::Spree::Country.default, skip_validation: false)
      end

      def before_payment
        if @order.checkout_steps.include? 'delivery'
          packages = @order.shipments.map(&:to_package)
          @differentiator = ::Spree::Stock::Differentiator.new(@order, packages)
          @differentiator.missing.each do |variant, quantity|
            ::Spree::Dependencies.cart_remove_item_service.constantize.call(order: @order, variant: variant, quantity: quantity)
          end
        end
        @order.bill_address ||= ::Spree::Address.new(country: ::Spree::Country.default, skip_validation: true)
        @order.bill_address.social_reason = @order.ship_address.firstname.to_s + ' ' + @order.ship_address.lastname.to_s
        @payment_sources = try_spree_current_user.payment_sources if try_spree_current_user&.respond_to?(:payment_sources)
      end

    end
  end
end

Spree::CheckoutController.prepend StoreFrontend::Spree::CheckoutControllerDecorator
