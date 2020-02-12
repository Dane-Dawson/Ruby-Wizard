class CodeMonkey < Challenge
    after_initialize :init
    def init
       self.name ||= "Code Monkey" 
       self.description ||= "Although they always seem to be busy, you can never find them when you need them for work. After being stuck debugging the same issue for the past 3 months you better be wary!"
       self.stealth ||= 1
       self.health ||= 15
       self.armor ||= 1
       self.strength ||= 1 # for now becuase otherwise the player will die
       self.element ||= "fire"
    end

    def attacks
        [
            {
                damage: 1,
                self_damage: 1,
                description: "The #{self.name} flings a stick at you while screaming that you don't know anything! It then huddles up on the branch and mutters to itself, petting its tail in a self-reasuring manner" 
            },
            {
                damage: 0,
                self_damage: 0,
                description: "The #{self.name} ignores you, grooming itself"
            },
            {
                damage: 2,
                self_damage: 0,
                description: "The #{self.name} punches you in the jaw."
            }
        ]
    end

    def get_random_attack
        attacks.sample
    end
end