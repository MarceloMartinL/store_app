require 'rails_helper'

RSpec.describe 'ProductStore', type: :request do
  let!(:store_1) { create(:store) }
  let!(:store_2) { create(:store) }
  let!(:product_1) { create(:product) }
  let!(:product_2) { create(:product) }
  let!(:product_stores_1) { create(:product_store, store: store_1, product: product_1) }
  let!(:product_stores_2) { create(:product_store, store: store_1, product: product_2) }

  describe 'GET /api/v1/stores/:store_id/product_stores' do
    before { get "/api/v1/stores/#{store_1.id}/product_stores" }

    it 'returns the stores' do
      expect(json_response).not_to be_empty
      expect(json_response.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/v1/stores/:store_id/product_stores' do
    let(:valid_params) {
      {
        product_stores: {
          product_id: product_1.id
        }
      }
    }

    context 'when the request is valid' do
      before { post "/api/v1/stores/#{store_2.id}/product_stores", params: valid_params }

      it 'creates the product_store' do
        expect(json_response[:store_id]).to eq(store_2.id)
        expect(json_response[:product_id]).to eq(product_1.id)
      end

      it 'links the product to the store' do
        expect(store_2.product_stores.count).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_params) { { product_stores: { product_id: nil } } }

      before { post "/api/v1/stores/#{store_2.id}/product_stores", params: invalid_params }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json_response[:message]).to match(/Validation failed: Product must exist, Product can't be blank/)
      end
    end
  end

  describe 'DELETE /api/v1/stores/:store_id/product_stores' do
    before { delete "/api/v1/stores/#{store_1.id}/product_stores/#{product_stores_1.id}" }

    it 'deletes the record' do
      expect(store_1.product_stores.count).to eq(1)
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end