module SpreeFrontend
  module Spree
    module AddressDecorator
      ADDRESS_FIELDS   = %w(firstname lastname company phone dni address1 address2 country state city latitude longitude)
      
      attr_accessor :skip_validation

      def self.prepended(base)
        base.after_initialize :skip_validators, if: :with_nit
        base.after_find :skip_validators, if: :with_nit
        base.validates :phone, :dni, presence: true, numericality: true, unless: :with_nit
        
      end

      def skip_validators
        self.class.clear_validators!
        self.class.validates :nit, :social_reason, presence: true
      end

      def with_nit
        return false if self.skip_validation.blank? or @skip_validation.blank?
        true
      end

      def dni
        return 123123 if self[:country_id] == 233
        self[:dni]
      end

      def phone=(phone)
        self[:phone] = phone
        self[:phone] = 23452345234 if self[:country_id] == 233
      end
    end
  end
end

::Spree::Address.prepend SpreeFrontend::Spree::AddressDecorator if ::Spree::Address.included_modules.exclude?(SpreeFrontend::Spree::AddressDecorator)
