module Api
  module V1
    class ProductStoresController < ApplicationController
      before_action :set_store, only: [:index, :create, :destroy]

      def index
        @product_stores = @store.product_stores
        json_response(@product_stores, :ok)
      end

      def create
        @product_store = @store.product_stores.create!(product_stores_params)
        json_response(@product_store, :created)
      end

      def destroy
        @product = ProductStore.find(params[:id]).product
        @store.products.delete(@product)
        head :no_content
      end

      private
        def product_stores_params
          params.require(:product_stores).permit(:product_id)
        end

        def set_store
          @store = Store.find(params[:store_id])
        end
    end
  end
end