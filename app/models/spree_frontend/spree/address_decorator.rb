module SpreeFrontend
  module Spree
    module AddressDecorator
      ADDRESS_FIELDS = %w(firstname lastname company address1 address2 city zipcode country state phone reference)
    end
  end
end


# ::Spree::Address.prepend SpreeFrontend::Spree::AddressDecorator if ::Spree::Address.included_modules.exclude?(SpreeFrontend::Spree::AddressDecorator)