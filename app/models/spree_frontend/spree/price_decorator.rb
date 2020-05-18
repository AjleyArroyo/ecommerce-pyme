# module SpreeFrontend
#   module Spree
#     module PriceDecorator
#       def amount
#         unless variant.no_discount_mode || variant.product.no_discount_mode
#           if variant.product.discount
#             return self[:amount] * (1 - variant.product.discount / 100)
#           end
#         end
#         self[:amount]
#       end

#     end
#   end
# end


# ::Spree::Price.prepend SpreeFrontend::Spree::PriceDecorator if ::Spree::Price.included_modules.exclude?(SpreeFrontend::Spree::PriceDecorator)
