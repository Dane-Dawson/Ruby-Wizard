def intro_blink
    puts PASTEL.red(FONT.write("vvvvvvv", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("|||>RUBY<||", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("|>WIZARD<|", letter_spacing: 2))
    puts PASTEL.red(FONT.write("^^^^^^^^^^^^", letter_spacing: 2))
    sleep 0.4
    system "clear"
    puts PASTEL.red(FONT.write("vvvvvvv", letter_spacing: 2))
    puts PASTEL.bright_green(FONT.write("|||>RUBY<||", letter_spacing: 2))
    puts PASTEL.bright_green(FONT.write("|>WIZARD<|", letter_spacing: 2))
    puts PASTEL.red(FONT.write("^^^^^^^^^^^^", letter_spacing: 2))
    sleep 0.4
    system "clear"
end

def title_logo
    2.times {intro_blink}
    puts PASTEL.red(FONT.write("vvvvvvv", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("|||>RUBY<||", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("|>WIZARD<|", letter_spacing: 2))
    puts PASTEL.red(FONT.write("^^^^^^^^^^^^", letter_spacing: 2))
    sleep 0.5
end

def game_intro
    puts "\n" * 2
    PROMPT.say("Welcome to ", color: :green) 
    PROMPT.say("RUBY WIZARD ", color: :bright_red)
    PROMPT.say("!", color: :green) 
    puts "\n"
    x = PROMPT.yes?('Is this your first time playing? (type "y" for yes)', help_color: :green, active_color: :green)
    puts "\n" * 2
    if x 
        PROMPT.say("Thanks for giving this a shot! Despite what everyone else says about you, we think you're pretty cool.", color: :green)
    else
        PROMPT.say("Who cares! We don't have enough content for that to matter right now!", color: :green)
    end 
    puts "\n" * 2
    sleep(2)
    PROMPT.say("Ruby wizard is an educational text-based game focused on Ruby as a programming language", color: :bright_red)
    PROMPT.say("Please enjoy our alpha version! If you have any feedback or criticism, please note that we don't care.", color: :bright_red)
    puts "\n"
    sleep(4)
    PROMPT.say(". . . . . . . . . .", color: :red)
    sleep(1)
    puts "\n"
    PROMPT.say(". . . . . . . . . .", color: :red)
    sleep(1)
    puts "\n"
    PROMPT.say(". . . . . . . . . .", color: :red)
    sleep(1)
    puts "\n"
    PROMPT.say(". . .just kidding, we love feedback! Email notes to gotyouagain@wedontcare.com.", color: :bright_red)
    puts "\n" * 2
    sleep 1.2
    y = PROMPT.yes?('Are you ready to start?', help_color: :green, active_color: :green)
    puts "\n" * 2
    if y 
        PROMPT.say("Ha! That's what *you* think! Let's see if we can humble some of that hubris...", color: :bright_red)
    else
        PROMPT.say("Doesn't matter, let's go!", color: :bright_red) 
    end   
    puts "\n" * 2
    sleep(2)

end

def end_screen
    PROMPT.say("As you stumble through the clearing ahead, you notice...nothing. Absolutely nothing for you to fight or do.", color: :bright_red)
    PROMPT.ask("Did...did you win? Press enter to find out...")
    PROMPT.say("You did!!", color: :bright_red)
    PROMPT.ask("Press enter to win!")
    puts PASTEL.red(FONT.write(". . . . . . . . . . .", letter_spacing: 3))
    puts PASTEL.bright_red(FONT.write(" YOU   HAVE", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("CONQUERED", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("THIS ALPHA", letter_spacing: 2))
    puts PASTEL.red(FONT.write("^^^^^^^^^^^^^^", letter_spacing: 2))
end

def end_screen_failure
    puts PASTEL.bright_red(FONT.write("    GAME", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("    OVER", letter_spacing: 2))
end


def spell_prompt
    puts "\n" * 1
    PROMPT.say("xXxXxXxXxXxXxXxXxXxXxXxXxXxXxXx", color: :red)
    PROMPT.say("     It's your turn now!", color: :green)
    PROMPT.say("xXxXxXxXxXxXxXxXxXxXxXxXxXxXxXx", color: :red)
    puts "\n"
    spell = PROMPT.select("Pick which spell to cast", Spell.all.map{|spell| spell.name}, active_color: :bright_red, per_page: 6)
    
    spell
end

# TODO: Not used until we have multiple enemies
# def target_prompt(targets)
#     puts "\n" * 3
#     PROMPT.say("choose your spell wisely", color: :green)
#     spell = PROMPT.select("Pick which spell to cast", %w(Manabolt Inspect Frostbolt), active_color: :bright_red, per_page: 6)
#     spell
# end

def cast_spell(player, spell, target)
    # will modify based on attributes later
    # boost spell damage based on player attributes, etc.
    puts "\n"
    PROMPT.say("You cast #{spell.name}!", color: :blue)
    if spell.name == "Inspect"
        puts "\n"
        PROMPT.say("A #{target.name} is revealed!", color: :blue)
        target.stealth = false
        puts "\n"
        PROMPT.say("Name: ", color: :red)
        PROMPT.say("#{target.name}", color: :green)
        PROMPT.say("Description: ", color: :red)
        PROMPT.say("#{target.description}", color: :green)
        PROMPT.say("Current Health: ", color: :red)
        PROMPT.say("#{target.health}", color: :green)
        PROMPT.say("Armor: ", color: :red)
        PROMPT.say("#{target.armor}", color: :green)
        PROMPT.say("Element: ", color: :red)
        PROMPT.say("#{target.element}", color: :green)
        puts "\n"
        puts "\n"
        PROMPT.say("Look at all that information! See if your enemy has armor or an element, it could change your spell choice!", color: :bright_cyan)
        puts "\n"
        PROMPT.ask("(Take a moment to read and press enter to continue when ready...)")
    elsif spell.name == "Heal"
        player.health += spell.damage
        PROMPT.say("You feel slightly better. You now have #{player.health}")
    else
        target.receive_spell(spell)
        if !target.stealth
            PROMPT.say("The #{target.name} has #{target.health} health left!", color: :blue)
        else
            PROMPT.say("You can't see anything at all. I hope you aren't taking damage!", color: :blue)
        end
    end
end

def combat(player, challenge)
    # TODO: Singular challenge currently, will get multi-challenge support working later
    while(true)
        sleep 0.5
        if !challenge.stealth
            PROMPT.say("You have #{player.health} hp left, and #{challenge.name} has #{challenge.health} hp left.", color: :magenta)
        else
            PROMPT.say("You have #{player.health} hp left, and can't see anyone to attack?", color: :magenta)   
        end 
        player_turn(player, challenge)
    #   TODO: multi targets later 
    #   if not challenges.any?{ |challenge| challenge.health > 0}
        if challenge.health <= 0
            combat_victory(player)
            break;
        end

        challenge_turn(player, challenge)
        if player.health <= 0
            combat_failure(player)
            break;
        end

    #   challenges.each do |challenge|
    #       challenge_turn(player, challenge)
    #       if player.health <= 0
    #           combat_failure(player)
    #           break;
    #       end
    #    end
    end
end

def player_turn(player, target)
    spell_name = spell_prompt
    spell = Spell.find_by(name: spell_name)
    cast_spell(player, spell, target)
    player
    sleep 1.2
end

def challenge_turn(player, challenge)
    puts "\n"
    if !challenge.stealth
        PROMPT.say("xXxXxXxXxXxXxXxXxXxXxXxXxXxXxXx", color: :green)
        PROMPT.say("     #{challenge.name} takes a turn!", color: :red)
        PROMPT.say("xXxXxXxXxXxXxXxXxXxXxXxXxXxXxXx", color: :green)
    else
        PROMPT.say("xXxXxXxXxXxXxXxXxXxXxXxXxXxXxXx", color: :green)
        PROMPT.say("The unknown enemy takes a turn!", color: :red)
        PROMPT.say("xXxXxXxXxXxXxXxXxXxXxXxXxXxXxXx", color: :green)
    end
    puts "\n"
    
    player.take_damage(challenge.strength)
    if challenge.visible?
        if challenge.stealth
            PROMPT.say("Nothing happened. You still feel there's something watching you.", color: :blue)
        else
            PROMPT.say("Something attacks you. You take #{challenge.strength} damage. You now have #{player.health} health left. You should figure out what is in here!", color: :blue)
        end
    else
        # PROMPT.say("#{attack[:description]}", color: :blue)
        PROMPT.say("You take #{challenge.strength} damage. You now have #{player.health} health left.", color: :blue)
    end
    puts "\n"
    player
    sleep(1)
end

def combat_victory(player)
    # TODO: Make this pretty
    system "clear"
    puts "\n"
    PROMPT.say("Your enemy lies broken and defeated before you. What awaits you in your next challenge?", color: :bright_green)
    "VICTORY"
    puts "\n"
    sleep 0.5
end

def combat_failure(player)
    # TODO: Make this pretty
    system "clear"
    puts "\n"
    PROMPT.say("You lie broken and defeated. Your quest to become a mage is done.", color: :bright_magenta)
    "FAILED"
    puts "\n"
    sleep 0.5
end

def enter_location(player)
    encounter_challenge = Challenge.find_by(id: player.current_encounter)
    location = Location.find_by(id: player.current_encounter)
    box = TTY::Box.frame(width: 110, height: 5, align: :center, title: {top_left: location.name}, 
        style: {
            fg: :bright_green,
            bg: :black,
            border: {
              fg: :bright_red,
              bg: :black
            }
          }) do
        "#{location.description}"
    end
    puts "\n" * 2
    print box
    sleep(3)
    #PROMPT.say("You have entered #{location.name}. #{location.description}", color: :bright_red)
    puts "\n"
    PROMPT.say("Checking to see if there are enemies nearby...", color: :green)
    sleep(3)
    #encounter_challenges.each do |challenge|
        if !encounter_challenge.stealth
            puts "\n"
            PROMPT.say("~~~~~~~~~~~~~~~~~", color: :green)
            PROMPT.say("~~~~~~~~~~~~~~~~~", color: :green)
            PROMPT.say("You spotted one!", color: :red)
            PROMPT.say("~~~~~~~~~~~~~~~~~", color: :green)
            PROMPT.say("~~~~~~~~~~~~~~~~~", color: :green)
            puts "\n"
            sleep 1
            PROMPT.say("You see a #{encounter_challenge.name}. #{encounter_challenge.description}", color: :bright_red)
            sleep 0.5
        else
            puts "\n"
            PROMPT.say("You can't see anything...that can't be right, maybe try inspecting?", color: :bright_red)
            puts "\n"
        end
    #end
end

def reset_database
    Challenge.delete_all
    Encounter.delete_all
    Location.delete_all
    Spell.delete_all
    Spellbot.delete_all
end

def game_startup
    title_logo
    puts "\n" * 2
    game_intro
    # reset_database
    name = PROMPT.ask("What is your name?")
    player = Spellbot.new(name: name, current_encounter: 1)
    # TODO: change the number of challenges
    while player.current_encounter <= Encounter.last.id
        enter_location(player)
        encounter = Encounter.find_by(id: player.current_encounter)
        challenge = Challenge.find_by(id: player.current_encounter)
        # TODO: Will make multiple enemies available later. One enemy per challenge currently
        # challenges = Challenge.all.collect{ |challenge| Challenge.new(challenge) }
        combat(player, challenge)
        if player.health <= 0
            break;
        end
        player.current_encounter += 1
    end

    player.save
    if player.health <= 0
        end_screen_failure
    else
        end_screen
    end
end

