<h1>RUBY WIZARD</h1>

## INSTALL INSTRUCTIONS ##

-Clone the directory to your local device. 
<br>
-Using a code editing software like VScode or through the terminal open the directory.
<br>
-Using the terminal interface type the following commands. Press enter where you see (enter).
<br>
<br>
rake db:migrate
<br>
(enter)
<br>
rake db:seed
<br>
(enter)
<br>
<br>
-You should see some blocks of text scroll up the terminal when you enter the first command but nothing appear for the second command.
<br>
-in the terminal type the following and press enter:
<br>
ruby bin/run.rb
<br>
-Enjoy the game! If you experience any errors or want to exit press ctrl+c
<br>
<br>


## Introduction ##
Welcome to Ruby Wizard! 

This was a joint project created by Lugh Wilson and Dane Dawson over the course of a week at Flatiron programming bootcamp. We only started learning Ruby 2 weeks prior to starting this project, so any messiness or clunky portions of code please excuse. 

Ruby Wizard is intended to be an educational text based adventure focused on Ruby as a programming language with heavy influences from D&D, Kingdom Of Loathing, Monkey Island and ZORP. Players control a Spellbot that calls spells from the Spell database table and interacts through the encounter class to associated monsters, with one spell bringing a tutorial that covers some aspects of coding relevant to that encounter, one calling a display of attributes of the monster, and one healing the player.

Stretch goals for future development include:
 -  vastly expanding the gameplay encounter list and breaking down code logic into smaller portions for the tutorial aspect of the game
 -  Adding more elements to interact
 -  Multiple monsters possible in encounter
 -  Branching paths from locations for more variety/"choose your own adventure"
 -  Abiilty to upgrade spellbot and eventually write your own code that is stored as a spell


This is a running project we have planned, if you have any feedback or recommendations please send me a message on our github where you probably found this.



## Contributors guide ##

Don't. 

Just kidding! If you are interested in contributing in future development message either of the primary contributors on GitHub (Dane-Dawson or lughjw) and we will get back to you. 

## Notable parts of the project ##

As our first interaction with Ruby on any scale larger than one or two file interactions, there were a lot of components that gave our brain new wrinkles. Recognizing where it was needed and setting conditional loops at several places to check if the player was alive was tricky, and we learned about isolating code to prevent having to run the entire game every time we wanted to bug test a section. There are areas that we could streamline but we have deliberately left some things open to expand into some of our stretch goals when we have time to return to this project.