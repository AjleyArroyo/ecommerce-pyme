module SpreeFrontend
  module Spree
    module PriceDecorator
      attr_accessor :no_discount_mode

      def amount
        return self[:amount] if @no_discount_mode
        discount = variant.try(:product).try(:discount)
        discount ||= 0

        self[:amount] * (1 - discount / 100)
      end

    end
  end
end


::Spree::Price.prepend SpreeFrontend::Spree::PriceDecorator if ::Spree::Price.included_modules.exclude?(SpreeFrontend::Spree::PriceDecorator)
