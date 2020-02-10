class Challenge < ActiveRecord::Base
    belongs_to :encounter
    has_many :locations, through: :encounters

    def take_damage
        challenge.health -= spell.damage - challenge.health
    end

    def check_visibility
        challenge.stealth
    end

    def engage_element
        if challenge.element == "fire"
            if spell.element == "fire"
                spell.damage = 0
            end
            if spell.element == "water"
                spell.damage *= 2
            end
        end
        if challenge.element == "water"
            if spell.element == "water"
                spell.damage = 0
            end
            if spell.element == "fire"
                spell.damage *= 2
            end
        end
    end

    def check_and_engage_element
        if challenge.element 
            engage_element
        end
    end

    def recieve_spell(spell)
        if check_visibility
            check_and_engage_element
            take_damage
        else
            print "There is nothing to target!"
        end
        
    end
end