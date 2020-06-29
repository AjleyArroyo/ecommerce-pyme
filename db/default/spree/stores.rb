# A store was created on migration CreateStoreFromPreferences

store = Spree::Store.first

store.name = 'Caimango Marketplace'
store.code = 'caimango'
store.url = Rails.application.routes.default_url_options[:host] || 'caimango.com'
store.mail_from_address = 'equipo@caimango.com'
store.default_currency = 'BOB'
store.seo_title = 'Caimango Marketplace'
store.meta_description = 'Compra en Línea en toda Bolivia, Ropa, Muebles y Alimentos'
store.meta_keywords = 'caimango compra marketplace Bolivia venta pyme tienda'
store.facebook = 'caimango'
store.twitter = 'caimango'
store.instagram = 'caimango'
store.save!
puts 'Store updated'

