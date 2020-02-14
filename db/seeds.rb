bush = Bush.create
fieldod = Location.create(name: "Field of Despair", description: "Behold the Field of Despair! Marvel at the terrifying and dangerous challenges you must overcome to progress.")
encounter1 = Encounter.create(challenge_id: 1, location_id: 1)
tutorial1 = Tutorial.create(content: "Hey there! Don’t be worried, it’s just me, the SpellBot! I am the Object that will be casting all your spells for you today, lucky me. This first round of combat should be easy enough, as long as you aren’t deathly afraid of bushes or anything. Choose your spell from the list below, and it will call a Method (the spell you chose) on an Object (the bush). This is a great example of utilizing the basic building blocks that make up coding. At least, that’s what the guy who wrote the code thinks. Don’t worry for this level, it is impossible for you to lose here!", encounter_id: 1)

bat = Bat.create
emptycave = Location.create(name: "Empty(?) Cave", description: "Take a moment to rest in this empty cave...wait...do you hear that? Let's take a closer look...")
encounter2 = Encounter.create(challenge_id: 2, location_id: 2)
tutorial2 = Tutorial.create(content: "Hey look, you murdered a bush! Good job. Making your family so proud. Back to learning! One of the key aspects of programming with Objects we will focus on is Attributes. Future versions of this game will hopefully give this more justice than I can currently fit in the limited window I have here, but attributes can be used to track any kind of data you want stored within that object. You’ll notice as combat continues that the enemy is missing, and it prompts you to use the “Inspect” spell. This will read out some of the attributes we have associated with this Object to help give us the details that make them a “creature” instead of a “line of words and symbols” like code tends to look.", encounter_id: 2)

wolf = Werewolf.create
jungle = Location.create(name: "Jargon Jungle", description: "As you traverse through the jungle you can feel the hot, foreboding breath of something...evil. Things seem to be heating up, work fast")
encounter3 = Encounter.create(challenge_id: 3, location_id: 3)
tutorial3 = Tutorial.create(content: "Good job! And I would apologize about the terrible pun in that last challenge’s name, but I won’t because it was hilarious. In the previous encounter the bat had an attribute called “stealth”, and we set up a series of code so that when the player casts Inspect it switches the monster’s stealth attribute to visible, allowing players to target them. For this encounter try to inspect and look at the “Element” attribute. The game has been designed to recognize the element of each spell and monster when they interact and adjust damage accordingly. Experiment with trying different spells, but keep an eye on your health and don't let it hit 0!", encounter_id: 3)

monkey = CodeMonkey.create
cabin = Location.create(name: "Google's Private Cabin", description: "Whenever their top employees are behind schedule Google sends them to this isolated cabin in the woods. The raw, unfiltered magic has slowly changed them into something new and terrifying…")
encounter4 = Encounter.create(challenge_id: 4, location_id: 4)
tutorial4 = Tutorial.create(content: "Hahahaha, w-ERROR-wolf...oh man the programmer for this game is HILARIOUS! Anywho, this last round utilizes concepts from every previous level and the enemy does deal damage, so it IS possible to lose here! Also take note the Code Monkey has armor, meaning all your attacks damage will be reduced by 1. Be strong and code on!", encounter_id: 4)

##spells##
manabolt = Spell.create(name: "Manabolt", damage: 2, element: nil)
frostbolt = Spell.create(name: "Frostbolt", damage: 2, element: "water")
inspect = Spell.create(name: "Inspect", damage: 0, element: nil)
heal = Spell.create(name: "Heal", damage: 3, element: nil)
tutorial = Spell.create(name: "Tutorial", damage: 0, element: nil)

##players##
Spellbot.create(name: "player_1", current_encounter: 1, first_time: true)
Spellbot.create(name: "player_2", current_encounter: 1, first_time: false)
Spellbot.create(name: "player_3", current_encounter: 2, first_time: false)