require 'rails_helper'

describe User::SearchResultsController do
  let(:user) { create(:user) }

  describe "GET#index" do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      create_list(:search_result, 5, user: user)
    end

    it "renders the index with previous searched zones listed" do
      get :index, params: { id: user.id }
      expect(assigns(:previous_searches).count).to be(5) 
    end
  end

end