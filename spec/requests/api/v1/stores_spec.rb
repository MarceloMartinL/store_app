require 'rails_helper'

RSpec.describe 'Store', type: :request do
	let!(:stores) { create_list(:store, 3) }
	let(:store_id) { stores.first.id }

	describe 'GET /api/v1/stores' do

		before { get '/api/v1/stores' }

		it 'returns the stores' do
			expect(json_response).not_to be_empty
			expect(json_response.size).to eq(3)
		end

		it 'returns status code 200' do
			expect(response).to have_http_status(200)
		end
	end

	describe 'GET /api/v1/stores/:id' do

		before { get "/api/v1/stores/#{store_id}" }

		context 'when the record exist' do
			it 'returns the store' do
				expect(json_response).not_to be_empty
				expect(json_response[:id]).to eq(store_id)
			end

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end
		end

		context 'when the record does not exist' do
			let(:store_id) { 999 }

			it 'returns status code 404' do
				expect(response).to have_http_status(404)
			end

			it 'returns a not found message' do
				expect(json_response).to match(:message => "Couldn't find Store with 'id'=999")
			end
		end
	end

	describe 'POST /api/v1/stores' do
		let(:valid_params) { 
			{ 
				store: { 
					name: 'Papa Johns Providencia', 
					address: 'Av. providencia 123', 
					email: 'pjprov@example.com', 
					phone: '123123123' 
				}
			}
		}

		context 'when the request is valid' do
			before { post '/api/v1/stores/', params: valid_params }

			it 'creates the store' do
				expect(json_response[:name]).to eq('Papa Johns Providencia')
				expect(json_response[:address]).to eq('Av. providencia 123')
				expect(json_response[:email]).to eq('pjprov@example.com')
				expect(json_response[:phone]).to eq('123123123')
			end

			it 'returns status code 201' do
				expect(response).to have_http_status(201)
			end
		end

		context 'when the request is invalid' do
			let(:invalid_params) { { store: { name: nil, address: 'Av. testing 123' } } }

			before { post '/api/v1/stores/', params: invalid_params }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'returns a validation failure message' do
				expect(json_response[:message]).to match(/Validation failed: Name can't be blank/)
			end
		end
	end

	describe 'PUT /api/v1/stores/:id' do
		let(:valid_params) { { store: { name: 'Update test' } } }

		context 'when the record exist' do
			before { put "/api/v1/stores/#{store_id}", params: valid_params }

			it 'updates the record' do
				expect(json_response[:name]).to eq('Update test')
			end

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'DELETE /api/v1/stores/:id' do
		before { delete "/api/v1/stores/#{store_id}" }

		it 'deletes the record' do
			expect(Store.count).to eq(2)
		end

		it 'returns status code 204' do
			expect(response).to have_http_status(204)
		end
	end
end