module SpreeFrontend
  module Spree
    module PriceDecorator
      def amount
        unless variant.try(:no_discount_mode) || variant.try(:product).try(:no_discount_mode)
          if variant.try(:product).try(:discount)
            return self[:amount] * (1 - variant.try(:product).try(:discount) / 100)
          end
        end
        self[:amount]
      end
    end
  end
end


::Spree::Price.prepend SpreeFrontend::Spree::PriceDecorator if ::Spree::Price.included_modules.exclude?(SpreeFrontend::Spree::PriceDecorator)
