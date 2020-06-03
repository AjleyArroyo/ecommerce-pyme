module StoreFrontend
    module Spree
      module OrdersControllerDecorator

        def update
          @variant = Spree::Variant.find(params[:variant_id]) if params[:variant_id]
          if ::Spree::Cart::Update.call(order: @order, params: order_params).success?
            respond_with(@order) do |format|
              format.html do
                if params.key?(:checkout)
                  @order.next if @order.cart?
                  redirect_to checkout_state_path(@order.checkout_steps.first)
                else
                  #aqui llama al edit, necesito que lo llame como un js para craer el edit.js.erb y renderizar lo que yo quiera
                  redirect_to cart_path
                end
              end
            end
          else
            respond_with(@order)
          end
        end

        # Shows the current incomplete order from the session
        def edit
          @order = current_order || Order.incomplete.
              includes(line_items: [variant: [:images, :product, option_values: :option_type]]).
              find_or_initialize_by(token: cookies.signed[:token])
          associate_user
        end
      end
    end
  end
  
  Spree::OrdersController.prepend StoreFrontend::Spree::OrdersControllerDecorator
  