class User::SearchResultsController < ApplicationController
  include DisplayCase::ExhibitsHelper
  before_action :authenticate_user!

  def index
    @previous_searches = exhibit(current_user.search_results.order(created_at: :desc).limit(10))
  end

end