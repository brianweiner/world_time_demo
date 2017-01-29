class AddSearchResultsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :search_results, :user, index: true, foreign_key: true
  end
end
