class Spellbot < ActiveRecord::Base
    has_many :spells
    has_many :encounters
    has_many :challenges, through: :encounters
    has_many :locations, through: :encounters
    after_initialize :init

    def init 
        self.name ||= "Dalek"
        self.health ||= 10
        self.max_health ||= self.health
        self.current_encounter ||= 1
    end

    def take_damage(damage)
        self.health -= damage
    end

    def heal(amount)
        if self.health + amount > self.max_health
            self.health = self.max_health
        else
            self.health += amount 
        end
    end

    def change_encounter(encounter_num = self.current_encounter + 1)
        self.current_encounter += 1
        self.save
    end

    def cast_spell(spell_name)
        spell = Spells.find_by(name: spell_name)
        targets = Challenges.find_by(encounter_id: encounter_id)
        # will modify based on attributes later
        target.recieve_spell(spell)
    end

    def spell_prompt
        spell = PROMPT.select("Pick which spell to cast", %w(Manabolt Inspect Frostbolt), active_color: :bright_red, per_page: 6)
        PROMPT.say("You cast #{spell}!", color: :blue)
        cast_spell(spell)
    end

    def reset_stats
        self.health = 10
        self.max_health = self.health
        self.current_encounter = 1
    end
end