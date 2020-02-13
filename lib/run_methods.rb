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
    sleep 0.4
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
    PROMPT.say(". . .just kidding, we love feedback! Email notes to gotyouagain@wereallydontcare.com.", color: :bright_red)
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
            puts "\n"
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