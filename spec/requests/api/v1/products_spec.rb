require 'rails_helper'

RSpec.describe 'Product', type: :request do
	let!(:store) { create(:store) }
	let!(:product_1) { create(:product) }
	let!(:product_2) { create(:product) }
	let!(:product_stores_1) { create(:product_store, store: store, product: product_1) }
	let!(:product_stores_2) { create(:product_store, store: store, product: product_2) }

	describe 'GET /api/v1/stores/:store_id/products' do

		before { get "/api/v1/stores/#{store.id}/products" }

		it 'returns the store products' do
			expect(json_response).not_to be_empty
			expect(json_response.size).to eq(2)
		end

		it 'returns status code 200' do
			expect(response).to have_http_status(200)
		end
	end

	describe 'GET /api/v1/products/:id' do
		let(:product_id) { product_1.id }

		before { get "/api/v1/products/#{product_id}" }

		context 'when the record exist' do
			it 'returns the product' do
				expect(json_response).not_to be_empty
				expect(json_response[:id]).to eq(product_1.id)
			end

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end
		end

		context 'when the record does not exist' do
			let(:product_id) { 999 }

			it 'returns status code 404' do
				expect(response).to have_http_status(404)
			end

			it 'returns a not found message' do
				expect(json_response).to match(:message => "Couldn't find Product with 'id'=999")
			end
		end
	end

	describe 'POST /api/v1/stores/:store_id/products' do
		let(:valid_params) { 
			{ 
				product: { 
					name: 'Pizza Todas las carnes', 
					sku: 'sku_pizza_tlc', 
					type: 'pizza', 
					price: 12000
				}
			}
		}

		context 'when the request is valid' do
			before { post "/api/v1/stores/#{store.id}/products", params: valid_params }

			it 'creates the product' do
				expect(json_response[:name]).to eq('Pizza Todas las carnes')
				expect(json_response[:sku]).to eq('sku_pizza_tlc')
				expect(json_response[:type]).to eq('pizza')
				expect(json_response[:price]).to eq(12000)
			end

			it 'returns status code 201' do
				expect(response).to have_http_status(201)
			end
		end

		context 'when the request is invalid' do
			let(:invalid_params) { { product: { name: nil, sku: 'sku_test_01' } } }

			before { post "/api/v1/stores/#{store.id}/products", params: invalid_params }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'returns a validation failure message' do
				expect(json_response[:message]).to match(/Validation failed: Name can't be blank/)
			end
		end
	end

	describe 'PUT /api/v1/products/:id' do
		let(:valid_params) { { product: { name: 'Update product test' } } }

		context 'when the record exist' do
			before { put "/api/v1/products/#{product_1.id}", params: valid_params }

			it 'updates the record' do
				expect(json_response[:name]).to eq('Update product test')
			end

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'DELETE /api/v1/products/:id' do
		before { delete "/api/v1/products/#{product_2.id}" }

		it 'deletes the record' do
			expect(Product.count).to eq(1)
		end

		it 'returns status code 204' do
			expect(response).to have_http_status(204)
		end
	end
end