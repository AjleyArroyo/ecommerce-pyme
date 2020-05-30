module SpreeFrontend
  module Spree
    module AddressDecorator
      ADDRESS_FIELDS   = %w(firstname lastname company phone dni address1 address2 country state city)
      
      attr_accessor :skip_validation

      def self.prepended(base)
        base.after_initialize :skip_validators, if: :skip_validation
        base.after_find :skip_validators, if: :skip_validation
        base.validates :phone, :dni, presence: true, numericality: true, unless: :skip_validation
        
      end

      def skip_validators
        self.class.clear_validators!
        self.class.validates :nit, :social_reason, presence: true
      end
    end
  end
end

::Spree::Address.prepend SpreeFrontend::Spree::AddressDecorator if ::Spree::Address.included_modules.exclude?(SpreeFrontend::Spree::AddressDecorator)
