class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
        t.string :name
        t.string :description
        t.integer :path1_id
        t.integer :path2_id
        # t.text :ascii_art
    end
  end
end
