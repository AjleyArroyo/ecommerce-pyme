module StoreFrontend
  module Spree
    module HomeControllerDecorator
      def sale
        @products = ::Spree::Product.joins(:variants_including_master).all
        fresh_when etag: store_etag, last_modified: store_last_modified, public: true
      end
    end
  end
end

Spree::HomeController.prepend StoreFrontend::Spree::HomeControllerDecorator
