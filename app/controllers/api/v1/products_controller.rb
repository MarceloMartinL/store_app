module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_store, only: [:index, :create]
      before_action :set_product, only: [:show, :update, :destroy]

      def index
        @products = @store.products
        json_response(@products, :ok)
      end

      def create
        @product = @store.products.create!(product_params)
        json_response(@product, :created)
      end

      def show
        json_response(@product, :ok)
      end

      def update
        @product.update!(product_params)
        json_response(@product, :ok)
      end

      def destroy
        @product.destroy!
        head :no_content
      end

      private
        def product_params
          params.require(:product).permit(:name, :sku, :type, :price)
        end

        def set_store
          @store = Store.find(params[:store_id])
        end

        def set_product
          @product = Product.find(params[:id])
        end
    end
  end
end