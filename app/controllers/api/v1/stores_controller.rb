module V1
  class StoresController < ApplicationController
    before_action :set_store, only: [:show, :update, :delete]

    def index
      
    end

    def create
      
    end

    def show
      
    end

    def update
      
    end

    def delete
      
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