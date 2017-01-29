require 'rails_helper'

describe SearchResultsController do
  let(:user) { create(:user) }

  describe "GET#index" do
    before do
      create_list(:search_result, 5)
    end

    it "renders the index with previous searched zones listed" do
      get :index
      expect(assigns(:previous_searches).count).to be(5) 
    end
  end

  ## These tests are slow, improvement would be to add VCR and cache the responses from geokit in cassettes
  describe "POST#create" do
    it "finds a location and creates a search result" do
      post :create, params: { search_result: { search_term: 'Baltimore' }}, format: :js
      expect(assigns(:result).state).to eq('MD')
      expect(SearchResult.count).to be(1)
      expect(response).to render_template(:create)
    end

    it "disregards a bad search term and returns an error" do
      post :create, params: { search_result: { search_term: 'Mxyzptlk' }}, format: :js
      expect(response).to render_template(:error)
    end

    context "with a signed in user" do
      before do
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end

      it "assigns the search result to the user" do
        post :create, params: { search_result: { search_term: 'Baltimore' }}, format: :js
        user.reload
        expect(user.search_results.count).to eq(1)
        expect(response).to render_template(:create)
      end
    end
  end
end