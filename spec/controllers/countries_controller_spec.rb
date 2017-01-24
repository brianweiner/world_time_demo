require 'rails_helper'

describe CountriesController do

  describe "GET#index" do
    it "renders the index with the countries listed" do
      get :index
      expect(assigns(:countries).count).to eq(249)
    end
  end

end