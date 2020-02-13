class Bush < Challenge
    # after_initialize is run whenever an instance of this class is created such as create and new
    after_initialize :init

    def init
        # The ||= is there for if we want to set other values when we're creating them
        self.name ||= "A Bush"
        self.description ||= "Just...a bush. Why do you need to kill a bush? You monster."
        self.element ||= nil
        self.health ||= 3
        self.armor ||= 0
        self.strength ||= 0
        self.stealth ||= 0
    end

    def attacks
        [
            {
                damage: 0,
                self_damage: 0,
                description: "The Bush sits there and does nothing. What else did you expect? It's a bush."
            }
        ]
    end

    def get_random_attack
        attacks.sample
    end
end