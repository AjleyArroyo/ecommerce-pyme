module StoreFrontend
    module Spree
      module CheckoutControllerDecorator
        def before_address
            @order.ship_address ||= ::Spree::Address.build_default if @order.checkout_steps.include?('delivery')
          end
      end
    end
  end
  
  Spree::CheckoutController.prepend StoreFrontend::Spree::CheckoutControllerDecorator
  