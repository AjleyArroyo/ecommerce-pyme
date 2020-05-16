module SpreeFrontend
  module Spree
    module VariantDecorator
      attr_accessor :no_discount_mode
    end
  end
end


::Spree::Variant.prepend SpreeFrontend::Spree::VariantDecorator if ::Spree::Variant.included_modules.exclude?(SpreeFrontend::Spree::VariantDecorator)
