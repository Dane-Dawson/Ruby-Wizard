class CreateTutorials < ActiveRecord::Migration[5.0]
  def change
    create_table :tutorials do |t|
      t.text :content
      t.integer :encounter_id
    end
  end
end
