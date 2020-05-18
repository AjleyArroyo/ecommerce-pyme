Rails.application.routes.draw do
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to
  # Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the
  # :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being
  # the default of "spree".
  mount Spree::Core::Engine, at: '/'
<<<<<<< HEAD
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Spree::Core::Engine.routes.draw do
  # end
=======
  
  Spree::Core::Engine.routes.draw do
    get "/sale" => "home#sale"
  end
>>>>>>> 04d7f75d956c5cdcf35b0a2226707d6a39b9c76f
end
