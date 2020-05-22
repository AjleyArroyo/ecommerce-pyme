module StoreFrontend
  module Spree
    module HomeControllerDecorator
      include ::Spree::FrontendHelper

      # This method is no longer valid. Discounted products now have their own taxon
      # def index
      #   @searcher = build_searcher(params.merge(include_images: true))
      #   @products = @searcher.retrieve_products
      #   @products_with_discount = @searcher.retrieve_products.where.not(discount: nil).all
      #   last_modified = @products.maximum(:updated_at)&.utc if @products.respond_to?(:maximum)
      #
      #   etag = [
      #     store_etag,
      #     last_modified&.to_i,
      #     available_option_types_cache_key,
      #     filtering_params_cache_key
      #   ]
      #   # @products = ::Spree::Product.joins(:variants_including_master).where(discount: nil).all
      #   fresh_when etag: etag, last_modified: store_last_modified, public: true
      # end
    end
  end
end

Spree::HomeController.prepend StoreFrontend::Spree::HomeControllerDecorator
