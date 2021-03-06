# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# Note: If a preference is set here it will be stored within the cache & database upon initialization.
#       Just removing an entry from this initializer will not make the preference value go away.
#       Instead you must either set a new value or remove entry, clear cache, and remove database entry.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
  config.products_per_page = 12
  config.logo = 'logo/caimango.png'
  config.admin_interface_logo = 'logo/caimango.png'

end

# Configure Spree Dependencies
#
# Note: If a dependency is set here it will NOT be stored within the cache & database upon initialization.
#       Just removing an entry from this initializer will make the dependency value go away.
#
Spree.dependencies do |dependencies|
  # Example:
  # Uncomment to change the default Service handling adding Items to Cart
  # dependencies.cart_add_item_service = 'MyNewAwesomeService'
end


Spree.user_class = "Spree::User"
Spree::Frontend::Config[:locale] = :es
Spree::Backend::Config[:locale] = :es
Spree::Auth::Config[:confirmable] = true
Spree::PermittedAttributes.address_attributes << :dni
Spree::PermittedAttributes.address_attributes << :skip_validation
Spree::PermittedAttributes.address_attributes << :nit
Spree::PermittedAttributes.address_attributes << :social_reason
Spree::PermittedAttributes.address_attributes << :latitude
Spree::PermittedAttributes.address_attributes << :longitude
Spree::PermittedAttributes.stock_location_attributes << :latitude
Spree::PermittedAttributes.stock_location_attributes << :longitude
Spree::Config[:checkout_zone] = 'South America'
Spree::Config[:default_country_id] = 29
Spree::Config[:currency] = 'BOB'
SpreeI18n::Config[:available_locales] = ['es-EC']

# attachment_config = {
#   s3_credentials: {
#     access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
#     secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
#     bucket:            ENV['S3_BUCKET_NAME']
#   },

#   storage:        :s3,
#   s3_region:      ENV['S3_REGION'],
#   s3_headers:     { "Cache-Control" => "max-age=31557600" },
#   s3_protocol:    "https",
#   bucket:         ENV['S3_BUCKET_NAME'],
#   url:            ":s3_domain_url",

#   path:           "/:class/:id/:style/:basename.:extension",
#   default_url:    "/:class/:id/:style/:basename.:extension",
# }

# attachment_config.each do |key, value|
#   Spree::Image.attachment_definitions[:attachment][key.to_sym] = value
# end
