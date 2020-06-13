module SpreeFrontend
  module Spree
    module AddressDecorator
      
      ADDRESS_FIELDS   = %w(firstname lastname company phone dni address1 address2 country state city)
      
      def self.prepended(base)
        base.after_initialize :with_nit
        # base.after_find :with_nit
        base.validates :phone, :dni, presence: true, numericality: true, unless: :skip_validation  
      end
      
      def skip_validators
        self.class.clear_validators!
        self.class.validates :nit, :social_reason, presence: true
      end
      
      def with_nit
        if self.skip_validation.presence or @skip_validation.presence
          skip_validators
          return true
        else
          unless self.skip_validation
            self.class.clear_validators!
            self.class.validates :firstname, :lastname, :country, :state, :phone, :dni, :address1, :city, presence: true
            self.class.validates :phone, :dni, numericality: true
          end 
        end
        false
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
