module Api
  module V1
    class StoresController < ApplicationController
      before_action :set_store, only: [:show, :update, :destroy]

      def index
        @stores = Store.all
        json_response(@stores, :ok)
      end

      def create
        @store = Store.new(store_params)
        @store.save!
        json_response(@store, :created)
      end

      def show
        json_response(@store, :ok)
      end

      def update
        @store.update!(store_params)
        json_response(@store, :ok)
      end

      def destroy
        @store.destroy!
        head :no_content
      end

      private
        def store_params
          params.require(:store).permit(:name, :address, :email, :phone)
        end

        def set_store
          @store = Store.find(params[:id])
        end
    end
  end
end