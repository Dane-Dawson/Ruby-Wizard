class CreateSpellbots < ActiveRecord::Migration[5.0]
  def change
    create_table :spellbots do |t|
      t.string :name
      t.integer :hp
      t.integer :current_encounter
    end
  end
end
