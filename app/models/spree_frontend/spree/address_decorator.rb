module SpreeFrontend
  module Spree
    module AddressDecorator
      ADDRESS_FIELDS = %w(firstname lastname company phone dni address1 address2 country state city)
      
      def self.prepended(base)
        base.validates :phone, :dni, presence: true
      end
    end
  end
end

::Spree::Address.prepend SpreeFrontend::Spree::AddressDecorator if ::Spree::Address.included_modules.exclude?(SpreeFrontend::Spree::AddressDecorator)
