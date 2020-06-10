# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Spree::Core::Engine.load_seed if defined?(Spree::Core)
store = Spree::Store.first
if store
  store.name = 'Caimango Marketplace'
  store.url = 'caimango.com'
  store.seo_title = 'Caimango Marketplace'
  store.meta_description = 'Compra en Línea en toda Bolivia, Ropa, Muebles y Alimentos'
  store.meta_keywords = 'caimango compra marketplace Bolivia venta pyme tienda'
  store.mail_from_address = 'equipo@caimango.com'
  store.default_currency = 'BOB'
  store.save!
  puts 'Tienda actualizada'
end

zone = Spree::Zone.where(name: 'Bolivia', description: 'Zona de Santa Cruz', kind: 'state').first_or_create!
zone.zone_members.where(zoneable: Spree::State.find(3116)).first_or_create!
puts 'Zona Agregada'

category = Spree::Taxonomy.where(name: 'Categorías').first_or_create!
categories_taxon = Spree::Taxon.where(name: 'Categorías').first_or_create!
Spree::Taxonomy.where(name: 'Descuentos').first_or_create!
Spree::Taxon.where(name: 'Descuentos').first_or_create!
Spree::Taxonomy.where(name: 'Más Vendidos').first_or_create!
Spree::Taxon.where(name: 'Más Vendidos').first_or_create!
Spree::Taxonomy.where(name: 'Tendencia').first_or_create!
Spree::Taxon.where(name: 'Tendencia').first_or_create!
puts 'Taxonomy Agregados'

['Mujeres', 'Hombres', 'Infantil', 'Muebles', 'Alimentos', 'Tecnología'].each do |taxon_name|
  taxon = categories_taxon.children.where(name: taxon_name).first_or_create!
  taxon.permalink = taxon.permalink.gsub('categories/', '')
  taxon.taxonomy = category
  taxon.save!
end
puts 'Taxon Agregados'
[
  ['Mujeres', 'Ropa Deportiva'], 
  ['Mujeres', 'Blusas y Poleras'], 
  ['Mujeres', 'Pantalones y Shorts'], 
  ['Mujeres', 'Zapatos y Zapatillas'], 
  ['Mujeres', 'Lencería'], 
  ['Mujeres', 'Accesorios'], 
  ['Hombres', 'Billeteras y Cinturones'], 
  ['Hombres', 'Pantalones y Shorts'], 
  ['Hombres', 'Zapatos'], 
  ['Hombres', 'Poleras'], 
  ['Infantil', 'Ropa de Niña'], 
  ['Infantil', 'Ropa de Niño'], 
  ['Infantil', 'Bebes'], 
  ['Infantil', 'Juguetes'], 
  ['Muebles', 'Comedor y Sala'],
  ['Muebles', 'Dormitorio'],
  ['Muebles', 'Juegos de Cocina'],
  ['Muebles', 'Muebles de Jardín']
].each do |(parent_name, taxon_name)|
  parent = Spree::Taxon.where(name: parent_name).first
  taxon = parent.children.where(name: taxon_name).first_or_create!
  taxon.permalink = taxon.permalink.gsub('categories/', '')
  taxon.taxonomy = category
  taxon.save!
end
puts 'Taxons Agregados'
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)