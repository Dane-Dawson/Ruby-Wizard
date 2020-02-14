class CreateSpellbots < ActiveRecord::Migration[5.0]
  def change
    create_table :spellbots do |t|
      t.string :name
      t.integer :health
      t.integer :max_health
      t.integer :current_encounter
      t.boolean :first_time
    end
  end
end
