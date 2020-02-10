class Spellbot < ActiveRecord::Base
    has_many :spells
    has_many :encounters
    has_many :challenges, through: :encounters
    has_many :locations, through: :encounters

    def cast_spell(spell_name, target_name)
        spell = spells.find_by_name(spell_name)
        target = challenges.find_by_name(target_name)
        # will modify based on attributes later
        target.recieve_spell(spell)

    end
end