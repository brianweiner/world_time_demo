class SearchResult < ActiveRecord::Migration[5.0]
  def change
    create_table :search_results do |t|
      t.string    :country,  null: false
      t.string    :city   
      t.string    :state
      t.string    :zip  
      t.string    :search_term,   null: false
      t.float     :latitude,      null: false
      t.float     :longitude,     null: false
      t.timestamps
    end
  end
end
