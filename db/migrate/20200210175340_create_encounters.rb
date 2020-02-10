class CreateEncounters < ActiveRecord::Migration[5.0]
  def change
    create_table :encounters do |t|
      t.integer :challenge_id
      t.integer :location_id
    end
  end
end
