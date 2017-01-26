require 'rails_helper'

describe SearchResultController do

  describe "GET#index" do
    it "renders the index with the countries listed" do
      get :index

    end
  end

end