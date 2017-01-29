class AddWikiLinksToSearchResult < ActiveRecord::Migration[5.0]
  def change
    add_column :search_results, :city_wiki_url, :string
    add_column :search_results, :country_wiki_url, :string
    add_column :search_results, :state_wiki_url, :string
    add_column :search_results, :search_term_wiki_url, :string
  end
end
