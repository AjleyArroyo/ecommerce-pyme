module ApplicationHelper

  def display_no_discount_price(product_or_variant)
    product_or_variant.no_discount_mode = true
    product_or_variant.
        price_in(current_currency).
        display_price_including_vat_for(current_price_options).
        to_html
  end

  # def available_option_types_cache_key
  #   @available_option_types_cache_key ||= Spree::OptionType.maximum(:updated_at)&.utc&.to_i
  # end

end
