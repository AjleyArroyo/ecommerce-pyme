# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


default_path = File.join(File.dirname(__FILE__), 'default')

Rake::Task['db:load_dir'].reenable
Rake::Task['db:load_dir'].invoke(default_path)


"" "
Payment Methods
" ""
Spree::PaymentMethod.where(
    type: 'Spree::PaymentMethod::Check',
    name: 'Efectivo',
    description: 'Método de pago por defecto (Contraentrega)',
    active: true,
    display_on: :both,
    store: Spree::Store.default
).first_or_create!


"" "
Shipping Methods
" ""
shipping_category = Spree::ShippingCategory.find_or_create_by!(name: 'Default')
shipping_methods = [
    {
        name: 'Envío Regular (1 a 3 días)',
        zones: [Spree::Zone.find_by_name('Bolivia')],
        display_on: 'both',
        shipping_categories: [shipping_category]
    }
]
shipping_methods.each do |attributes|
  Spree::ShippingMethod.where(name: attributes[:name]).first_or_create! do |shipping_method|
    shipping_method.calculator = Spree::Calculator::Shipping::FlatRate.create!
    shipping_method.zones = attributes[:zones]
    shipping_method.display_on = attributes[:display_on]
    shipping_method.shipping_categories = attributes[:shipping_categories]
  end
end
{'Envío Regular (1 a 3 días)' => [20, 'BOB'], }.each do |shipping_method_name, (price, currency)|
  shipping_method = Spree::ShippingMethod.find_by!(name: shipping_method_name)
  shipping_method.calculator.preferences = {
      amount: price,
      currency: currency
  }
  shipping_method.calculator.save!
  shipping_method.save!
end


"" "
Return Authorization Reasons
" ""
Spree::ReturnAuthorizationReason.update(
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [
        {name: 'Mejor precio disponible', active: false},
        {name: 'Retraso según la fecha de envío estimada', active: true},
        {name: 'Partes o accesorios faltantes', active: true},
        {name: 'Dañado/Defectuoso', active: true},
        {name: 'Diferente de lo que se ha ordenado', active: true},
        {name: 'Diferente de la descripción', active: true},
        {name: 'Ya no lo necesito/quiero', active: false},
        {name: 'Pedido erróneo', active: true},
        {name: 'Compra no autorizada', active: false}
    ]
)

"""
Taxons and Taxonomies
"""

discounts = Spree::Taxonomy.where(name: 'Descuentos', position: 1).first_or_create!
categories = Spree::Taxonomy.where(name: 'Categorías', position: 2).first_or_create!
bestsellers = Spree::Taxonomy.where(name: 'Más Vendidos', position: 3).first_or_create!
trending = Spree::Taxonomy.where(name: 'Tendencia', position: 4).first_or_create!


Spree::Taxon.where(name: 'Descuentos', taxonomy: discounts).first_or_create!
Spree::Taxon.where(name: 'Más Vendidos', taxonomy: bestsellers).first_or_create!
Spree::Taxon.where(name: 'Tendencia', taxonomy: trending).first_or_create!
categories_taxon = Spree::Taxon.where(name: 'Categorías', taxonomy: categories).first_or_create!



def load_taxons(taxons, parent, taxonomy)
  taxons.each do |t|
    taxon = parent.children.where(name: t['name'], permalink: t['permalink']).first_or_create!
    taxon.taxonomy = taxonomy
    taxon.save!
    load_taxons(t['taxons'], taxon, taxonomy) if t['taxons']
  end
end

file = File.open(File.join(File.dirname(__FILE__), 'default/spree/categories.json'))
taxons = JSON.load file
load_taxons(taxons, categories_taxon, categories)


country = Spree::Country.find_by(iso: 'BO')
location = Spree::StockLocation.find_or_create_by!(name: 'default')
location.update_attributes!(
    address1: 'Dr. Horacio Sosa 63',
    city: 'Santa Cruz de la Sierra',
    zipcode: '10260',
    country: country,
    state: country.states.find_by_abbr!('S'),
    active: true
)
puts 'Actualizar Ubicación de stock'

Spree::Auth::Engine.load_seed if defined?(Spree::Auth)