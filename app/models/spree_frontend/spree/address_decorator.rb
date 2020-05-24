module SpreeFrontend
  module Spree
    module AddressDecorator
      ADDRESS_FIELDS   = %w(firstname lastname company phone dni address1 address2 country state city)
      
      attr_accessor :skip_validation

      def self.prepended(base)
        base.validates :firstname, :lastname, presence: true, if: :skip_validation
        base.validates :phone, :dni, presence: true, numericality: true, if: :skip_validation
        base.validates :nit, :social_reason, presence: true, unless: :skip_validation
      end

      def bill_validator
        _validators.reject! { |attribute, _| attribute == :firstname }
      end

    end
  end
end

::Spree::Address.prepend SpreeFrontend::Spree::AddressDecorator if ::Spree::Address.included_modules.exclude?(SpreeFrontend::Spree::AddressDecorator)
