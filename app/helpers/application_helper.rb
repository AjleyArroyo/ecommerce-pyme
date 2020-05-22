module ApplicationHelper
  include ::Spree::ProductsHelper
  
  def display_no_discount_price(product_or_variant)
    price = product_or_variant.price_in(current_currency)
    price.no_discount_mode = true
    html = price.display_price_including_vat_for(current_price_options).to_html
    price.no_discount_mode = false
    html
  end

end
