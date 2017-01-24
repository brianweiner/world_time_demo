class CountriesController < ApplicationController
  include DisplayCase::ExhibitsHelper
  # ...
  def index
    # display_case automatically wraps the individual objects contained in
    # an Enumerable or ActiveRecord::Relation collections
    @countries = exhibit(Country.all)
  end
end