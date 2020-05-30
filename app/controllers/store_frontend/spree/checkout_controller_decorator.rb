module StoreFrontend
    module Spree
      module CheckoutControllerDecorator

        def before_address
          @order.ship_address ||= ::Spree::Address.build_default if @order.checkout_steps.include?('delivery')
        end

        def before_payment
          if @order.checkout_steps.include? 'delivery'
            packages = @order.shipments.map(&:to_package)
            @differentiator = ::Spree::Stock::Differentiator.new(@order, packages)
            @differentiator.missing.each do |variant, quantity|
              ::Spree::Dependencies.cart_remove_item_service.constantize.call(order: @order, variant: variant, quantity: quantity)
            end
          end
          @order.bill_address ||= ::Spree::Address.build_default
          @order.bill_address.skip_validation = true
          @order.bill_address.social_reason = @order.ship_address.firstname.to_s + ' ' + @order.ship_address.lastname.to_s
          @payment_sources = try_spree_current_user.payment_sources if try_spree_current_user&.respond_to?(:payment_sources)
        end

      end
    end
  end
  
  Spree::CheckoutController.prepend StoreFrontend::Spree::CheckoutControllerDecorator
  