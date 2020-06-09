module SpreeFrontend
  module Spree
    module AddressDecorator
      ADDRESS_FIELDS   = %w(firstname lastname company phone dni address1 address2 country state city)
      
      def self.prepended(base)
        base.with_options unless: :skip_validation do
          base.validates :phone, :dni, presence: true, numericality: true
          base.validates :firstname, :lastname, presence: true
        end
        base.with_options if: :skip_validation do
          base.clear_validators!
          base.validates :nit, :social_reason, presence: true
        end
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
