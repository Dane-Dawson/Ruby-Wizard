class Werewolf < Challenge
    # after_initialize is run whenever an instance of this class is created such as create and new
    after_initialize :init

    def init
        # The ||= is there for if we want to set other values when we're creating them
        self.name ||= "w-ERROR-wolf"
        self.description ||= "After being bitten by a broken but enchanted line of code, these wolves are driven to growl loudly at every full moon. If you could speak wolf you’d know they said ErrorMethod: Undefined method ‘howl_at_moon’."
        self.element ||= "fire"
        self.health ||= 10
        self.armor ||= 0
        self.strength ||= 1
        self.stealth ||= false
    end

    def attacks
        [
            {
                damage: 1,
                self_damage: 0,
                description: "The #{self.name} howls at you filling you with dread...but thankfully doing no actual damage." 
            },
            {
                damage: 0,
                self_damage: 0,
                description: "The #{self.name} ignores you, grooming itself. What a prima-donna!"
            },
            {
                damage: 2,
                self_damage: 0,
                description: "The #{self.name} bites you. You think you hear a faint sound of static coming from far away. Or is that just in your mind?"
            }
        ]
    end

    def get_random_attack
        attacks.sample
    end
end