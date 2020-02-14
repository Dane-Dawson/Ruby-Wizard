def intro_blink
    puts PASTEL.red(FONT.write("vvvvvvv", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("|||>RUBY<|||", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("|>WIZARD <|", letter_spacing: 2))
    puts PASTEL.red(FONT.write("^^^^^^^^^^^^", letter_spacing: 2))
    sleep 0.6
    system "clear"
    puts PASTEL.red(FONT.write("vvvvvvv", letter_spacing: 2))
    puts PASTEL.bright_green(FONT.write("|||>RUBY<|||", letter_spacing: 2))
    puts PASTEL.bright_green(FONT.write("|>WIZARD <|", letter_spacing: 2))
    puts PASTEL.red(FONT.write("^^^^^^^^^^^^", letter_spacing: 2))
    sleep 0.6
    system "clear"
end

def title_logo
    3.times {intro_blink}
    puts PASTEL.red(FONT.write("vvvvvvv", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("|||>RUBY<|||", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("|>WIZARD <|", letter_spacing: 2))
    puts PASTEL.red(FONT.write("^^^^^^^^^^^^", letter_spacing: 2))
    sleep 1.4
end

def game_intro
    puts "\n" * 2
    PROMPT.say("Welcome to ", color: :green) 
    PROMPT.say("RUBY WIZARD ", color: :bright_red)
    PROMPT.say("!", color: :green) 
    puts "\n"
    first_time = PROMPT.yes?('Is this your first time playing? (Yes here will auto-trigger the tutorial on every level)', help_color: :green, active_color: :green)
    puts "\n" * 2
    if first_time
        PROMPT.say("Thanks for giving this a shot! Despite what everyone else says about you, we think you're pretty cool.", color: :green)
    else
        PROMPT.say("You came back! Wonderful! We hate you slightly less now.", color: :green)
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
        PROMPT.say("Ha! That's what *you* think! Let's see how long that hubris holds out...", color: :bright_red)
    else
        PROMPT.say("Doesn't matter, let's go!", color: :bright_red) 
    end   
    puts "\n" * 2
    sleep(2)
    first_time
end

def end_screen
    PROMPT.say("As you stumble through the clearing ahead, you notice...nothing. Absolutely nothing for you to fight or do.", color: :bright_red)
    PROMPT.ask("Did...did you win? Press enter...")
    PROMPT.say("You did!!", color: :bright_red)
    PROMPT.ask("Congratulations!!")
    puts PASTEL.red(FONT.write(". . . . . . . . . . .", letter_spacing: 3))
    puts PASTEL.bright_red(FONT.write(" YOU   HAVE", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("CONQUERED", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("THIS ALPHA", letter_spacing: 2))
    puts PASTEL.red(FONT.write("^^^^^^^^^^^^^^", letter_spacing: 2))
end

def end_screen_failure
    puts PASTEL.bright_red(FONT.write("    GAME", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("    OVER", letter_spacing: 2))
    PROMPT.ask("Press enter to end the game. Maybe next time you won't be so terrible at it!", color: :bright_red)
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

    if player.first_time
        tutorial_box(player.current_encounter)
    end
    puts "\n"
    PROMPT.say("Checking to see if there are enemies nearby...", color: :green)
    sleep(2)
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
end

def game_loop(player)
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
        if player.current_encounter > Encounter.count
            player.current_encounter = 1
            break;
        end
        player.save
    end

    player.save
    if player.health <= 0
        end_screen_failure
    else
        end_screen
    end
    PROMPT.ask("Enter to return to main menu")
end

def new_game
    puts "\n" * 2
    first_time = game_intro
    name = PROMPT.ask("What is your name?")
    player = Spellbot.create(name: name, first_time: first_time)
    player.name = name
    player.save
    game_loop(player)
end

def show_stored_games
    if Spellbot.all.count == 0
        yn = PROMPT.yes?("You have no games saved! Start a new one!")
        if yn
            new_game
        end
        return 0
    end
    system "clear"
    Spellbot.all.each{|sb| print_spellbot(sb)}
    id = PROMPT.ask("Enter game number to continue") do |q|
        q.validate(/\d/)
        q.messages[:valid?] = 'Invalid entry. Try again.'
    end

    id.to_i
end

def load_game
    spellbot_id = show_stored_games
    if spellbot_id != 0
        spellbot = Spellbot.find_by(id: spellbot_id)
        if spellbot.health <= 0
            yn = PROMPT.yes?("This character wasn't strong enough to make it all the way. What a pity. Should we bring them back to life and start over?")
            if yn
                spellbot.reset_stats
                spellbot.save
            end
        end
        game_loop(spellbot)
    end
end

def delete_game
    spellbot_id = show_stored_games
    if spellbot_id != 0
        Spellbot.delete(spellbot_id.to_i)
    end
end

def main_menu
    loop do
        system "clear"
        choice = PROMPT.select("Welcome to Ruby Wizard!", %w(new_game load_game delete_game quit), active_color: :bright_red)
        if choice == "new_game"
            new_game
        elsif choice == "load_game"
            load_game
        elsif choice == "delete_game"
            delete_game
        else
            break;
        end
    end
end

def game_startup
    title_logo
    main_menu
end

def print_spellbot(spellbot)
    inspect_box = TTY::Box.frame(width: 100, align: :left, title: {top_left: "  #{spellbot.id}. #{spellbot.name}  "}, 
        style: {
            fg: :bright_white,
            bg: :black,
            border: {
            fg: :bright_yellow,
            bg: :black
            }
        }) do #first quote needs to be on individual line for formatting in TTY-box gem to indent line off box edge
        "
        Health => #{spellbot.health}
        Location => #{Location.find_by(id: spellbot.current_encounter).name}"
    end

    print inspect_box
end