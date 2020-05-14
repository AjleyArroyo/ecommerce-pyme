Devise.secret_key = "26e737dca1191d8a68b2ef99820845446afac6c26b1d4159bbdf1d78aca3f3794ec53973a6cd6d3d652de547a47a369b0652"

Devise.setup do |config|
  # Required so users don't lose their carts when they need to confirm.
  config.allow_unconfirmed_access_for = 1.days

  # Fixes the bug where Confirmation errors result in a broken page.
  config.router_name = :spree

  # Add any other devise configurations here, as they will override the defaults provided by spree_auth_devise.
end