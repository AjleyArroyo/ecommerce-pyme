module SpreeFrontend
  module Spree
    module ProductDecorator
      attr_accessor :no_discount_mode
    end
  end
end


::Spree::Product.prepend SpreeFrontend::Spree::ProductDecorator if ::Spree::Product.included_modules.exclude?(SpreeFrontend::Spree::ProductDecorator)
