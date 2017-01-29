require_relative "../services/location_finder"
require_relative "../services/wikipedia_finder"

class SearchResultsController < ApplicationController
  include DisplayCase::ExhibitsHelper

  def index
    @previous_searches = exhibit(SearchResult.order(created_at: :desc).limit(10))
  end

  def create
    @result = location_finder.locate(search_params[:search_term])
    verify_location; return if performed?
    
    @search_result = exhibit(SearchResult.create!(
                      search_term: search_params[:search_term],
                      country: @result.country,
                      city: @result.city,
                      state: @result.state_name,
                      latitude: @result.latitude,
                      longitude: @result.longitude,
                      user_id: current_user.id,
                      city_wiki_url: wikipedia.page_url(@result.city),
                      country_wiki_url: wikipedia.page_url(@result.country),
                      state_wiki_url: wikipedia.page_url(@result.state_name),
                      search_term_wiki_url: wikipedia.page_url(search_params[:search_term].gsub(',',' '))
                    ))

    if @search_result.errors.present?
      render :error
    end
  end

  private

  helper_method :location_finder

  def location_finder
    @location_finder ||= LocationFinder.new()
  end

  def search_params
    params.require(:search_result).permit(:search_term)
  end

  def verify_location
    render :error unless @result.success
  end

  def wikipedia
    @wikipedia ||= WikipediaFinder.new
  end

end