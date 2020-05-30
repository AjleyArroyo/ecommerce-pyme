module SpreeFrontend
  module Spree
    module ProductDecorator

      def self.prepended(base)
        base.before_validation :validate_discount
      end

      def validate_discount
        taxonomy = ::Spree::Taxonomy::find_or_create_by!(name: I18n.t('spree.taxonomy_discounts_name'))
        taxon = ::Spree::Taxon.find_or_create_by(name: I18n.t('spree.taxonomy_discounts_name'), taxonomy: taxonomy)
        if self[:discount] != nil and self[:discount] > 0
          self.taxons << taxon unless self.taxons.exists?(taxon.id)
        else
          self.taxons.delete(taxon)
        end
      end

    end
  end
end


::Spree::Product.prepend SpreeFrontend::Spree::ProductDecorator if ::Spree::Product.included_modules.exclude?(SpreeFrontend::Spree::ProductDecorator)
