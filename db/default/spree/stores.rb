# Possibly already created by a migration.
unless Spree::Store.default.persisted?
  Spree::Store.new do |s|
    s.name              = 'Caimango Marketplace'
    s.code              = 'caimango'
    s.url               = Rails.application.routes.default_url_options[:host] || 'caimango.com'
    s.mail_from_address = 'equipo@caimango.com'
    s.default_currency  = 'BOB'
    s.seo_title         = 'Caimango Marketplace'
    s.meta_description  = 'Compra en Línea en toda Bolivia, Ropa, Muebles y Alimentos'
    s.meta_keywords = 'caimango compra marketplace Bolivia venta pyme tienda'
    s.facebook          = 'caimango'
    s.twitter           = 'caimango'
    s.instagram         = 'caimango'
  end.save!
end
