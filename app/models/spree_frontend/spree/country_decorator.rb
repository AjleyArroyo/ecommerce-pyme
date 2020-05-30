module SpreeFrontend
    module Spree
      module CountryDecorator
        def self.prepended(base)
            base.has_many :states, -> { where(enabled: true).order(id: :desc) }, dependent: :destroy
        end
      end
    end
  end
  
  
  ::Spree::Country.prepend SpreeFrontend::Spree::CountryDecorator if ::Spree::Country.included_modules.exclude?(SpreeFrontend::Spree::CountryDecorator)
  