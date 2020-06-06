module Spree
  module Calculator::Shipping
    class DistanceMethod < ShippingCalculator
      preference :amount, :decimal, default: 0
      # preference :something_i_need, :string, default: :foo #and so on, those preferences will be ready to set/change in admin panel

      def self.description
        Spree.t(:distance_method) # just a label
      end

      # here is where magic happens
      def compute_package(package)
        package.order.shipment_total
      end

    end
  end
end