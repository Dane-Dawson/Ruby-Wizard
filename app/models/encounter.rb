class Encounter < ActiveRecord::Base
    belongs_to :spellbot
    has_many :challenges


    def enter_location
        print "You have entered #{location.name}. #{location.description}"
        challenges.each do |challenge|
            if !challenge.stealth
                print "You see a #{challenge.name}. #{challenge.description}"
            end
        end
    end

    def successfully_complete_challenge
        print "You did it!"
        



end