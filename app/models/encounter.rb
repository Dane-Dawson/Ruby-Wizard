class Encounter < ActiveRecord::Base
    belongs_to :spellbot
    has_many :challenges
    has_one :location


    def successfully_complete_challenge
        PROMPT.say("You did it! You have successfully defeated #{challenge.name}.", color: :green)
    end



end