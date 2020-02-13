class Challenge < ActiveRecord::Base
    belongs_to :encounter
    has_many :locations, through: :encounters
    after_initialize :init

    def init
        self.name ||= ""
        self.description ||= nil
        self.element ||= nil
        self.health ||= 10
        self.armor ||= 0
        self.strength ||= 0
        self.stealth ||= false
    end

    def take_damage(damage)
        if self.armor < damage
            self.health -= damage - self.armor
        end

        self.health
    end

    def visible?
        !self.stealth
    end

    def engage_element(spell)
        # works for now, but when we have more than 2 elements we'll need to change this
        # currently "fire", "water", and nil are the only values for element
        if self.element == spell.element
            spell.damage = 0
        else
            spell.damage *= 2
            PROMPT.say("Your element choice is super effective!", color: :bright_magenta)
        end
    end

    def check_and_engage_element(spell)
        if self.element && spell.element
            engage_element(spell)
        end
    end

    def receive_spell(spell)
        if self.visible?
            check_and_engage_element(spell)
            self.take_damage(spell.damage)
            spell.damage
        else
            puts ""
            PROMPT.say("There is nothing to target!", color: :bright_green)
            puts ""
        end
    end
end