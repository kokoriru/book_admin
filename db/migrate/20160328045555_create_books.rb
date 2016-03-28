class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.date :published_on
      t.integer :price
      t.integer :nmber_of_page

      t.timestamps null: false
    end
  end
end
