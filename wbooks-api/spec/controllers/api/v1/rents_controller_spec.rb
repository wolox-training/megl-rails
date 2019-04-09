require 'rails_helper'
require 'controllers/api/v1/authenticated_user'

describe Api::V1::RentsController do
  include_context 'Authenticated User'
  include Response::JSONParser

  describe 'GET #index' do
    context 'when fetching all the rents' do
      let!(:another_user) { create(:user) }
      let!(:rents) { create_list(:rent, 3, user: user) }
      let!(:rents_from_another_user) { create_list(:rent, 3, user: another_user) }

      before do
        get :index
      end

      it 'responses with all the rents from that user' do
        expected = JSON.parse(ActiveModel::Serializer::CollectionSerializer.new(
          rents, serializer: RentSerializer
        ).to_json)

        expect(expected).to eq response_body['page']
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'when fetching a rent' do
      let!(:rent) { create(:rent, user: user) }

      before do
        get :show, params: { id: rent.id }
      end

      it 'responses with the rent' do
        expected = JSON.parse(RentSerializer.new(
          rent
        ).to_json)

        expect(expected).to eq response_body
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when fetching an invalid rent' do
      before do
        get :show, params: { id: 1 }
      end

      it 'responds with 404 status' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when fetching a rent from another user' do
      let!(:another_user) { create(:user) }
      let!(:rent) { create(:rent, user: another_user) }

      before do
        get :show, params: { id: rent.id }
      end

      it 'responds with 404 status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'When creating a valid user rent' do
      let!(:book) { create(:book) }
      let!(:rent) { build(:rent, user: user, book: book).attributes }

      it 'creates a new rent' do
        expect do
          post :create, params: { rent: rent }
        end.to change { Rent.count }.by(1)
      end

      it 'responds with 201 status' do
        post :create, params: { rent: rent }
        expect(response).to have_http_status(:created)
      end
    end

    context 'When creating an invalid user rent' do
      let!(:rent) { attributes_for(:rent) }

      before do
        post :create, params: { rent: rent }
      end

      it 'doesn\'t create a new rent' do
        expect do
          post :create, params: { rent: rent }
        end.to change { Rent.count }.by(0)
      end

      it 'responds with 400 status' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
