require 'rails_helper'

RSpec.describe 'Order', type: :request do
  let!(:store_1) { create(:store) }
  let!(:store_2) { create(:store) }
  let!(:product_1) { create(:product) }
  let!(:product_2) { create(:product) }
  let!(:product_3) { create(:product) }
  let!(:product_stores_1) { create(:product_store, store: store_1, product: product_1) }
  let!(:product_stores_2) { create(:product_store, store: store_1, product: product_2) }
  let!(:product_stores_3) { create(:product_store, store: store_2, product: product_3) }
  let!(:order_1) { create(:order, store: store_1) }
  let!(:order_2) { create(:order, store: store_1) }
  let!(:order_product_1) { create(:order_product, order: order_1, product: product_1) }
  let!(:order_product_2) { create(:order_product, order: order_1, product: product_2) }

  describe 'GET /api/v1/stores/:store_id/orders' do
    before { get "/api/v1/stores/#{store_1.id}/product_stores" }

    it 'returns the orders of the store' do
      expect(json_response).not_to be_empty
      expect(json_response.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/orders/:id' do
    let(:order_id) { order_1.id }

    before { get "/api/v1/orders/#{order_id}" }

    context 'when the record exist' do
      it 'returns the order' do
        expect(json_response).not_to be_empty
        expect(json_response[:id]).to eq(order_1.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:order_id) { 999 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_response).to match(:message => "Couldn't find Order with 'id'=999")
      end
    end
  end

  describe 'POST /api/v1/stores/:store_id/orders' do
    let(:valid_params) {
      {
        order: {
          order_products_attributes: [
            { product_id: product_1.id },
            { product_id: product_2.id }
          ]
        }
      }
    }

    context 'when the request is valid' do
      before { post "/api/v1/stores/#{store_1.id}/orders", params: valid_params }

      it 'creates the order' do
        total_price = product_1.price + product_2.price
        expect(json_response[:store_id]).to eq(store_1.id)
        expect(json_response[:price]).to eq(total_price)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_params) { { order: { order_products_attributes: [{ product_id: nil }] } } }

      before { post "/api/v1/stores/#{store_1.id}/orders", params: invalid_params }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json_response[:message]).to match(/Validation failed: Order products product must exist, Order products product can't be blank/)
      end
    end

    context 'when the product does not belong to the store' do
      let(:invalid_params) { { order: { order_products_attributes: [{ product_id: product_3.id }] } } }

      before { post "/api/v1/stores/#{store_1.id}/orders", params: invalid_params }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json_response[:message]).to match("Validation failed: The product with ID=#{product_3.id} doesn't belongs to the store with ID=#{store_1.id}")
      end
    end
  end

  describe 'PUT /api/v1/orders/:id' do
    let(:valid_params) { { order: { order_products_attributes: [{ id: order_product_2.id, _destroy: true }] } } }

    context 'when the record exist' do
      before { put "/api/v1/orders/#{order_1.id}", params: valid_params }

      it 'updates the record' do
        expect(json_response[:price]).to eq(product_1.price)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /api/v1/orders/:id' do
    before { delete "/api/v1/orders/#{order_2.id}" }

    it 'deletes the record' do
      expect(Order.count).to eq(1)
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end