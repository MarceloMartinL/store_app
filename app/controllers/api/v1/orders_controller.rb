module Api
  module V1
    class OrdersController < ApplicationController
      before_action :set_store, only: [:index, :create]
      before_action :set_order, only: [:show, :update, :destroy]

      def index
        @orders = @store.orders
        json_response(@orders, :ok)
      end

      def create
        @order = @store.orders.create!(order_params)
        json_response(@order, :created)
      end

      def show
        json_response(@order, :ok)
      end

      def update
        @order.update!(order_params)
        json_response(@order, :ok)
      end

      def destroy
        @order.destroy!
        head :no_content
      end

      private
        def order_params
          params.require(:order).permit(order_products_attributes: [:id, :product_id, :_destroy])
        end

        def set_store
          @store = Store.find(params[:store_id])
        end

        def set_order
          @order = Order.find(params[:id])
        end
    end
  end
end