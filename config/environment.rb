require 'bundler'
require 'tty-prompt'
Bundler.require


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
# Makes the logger not spit out all the debug messages it was before.
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger.level = 1

PROMPT = TTY::Prompt.new
FONT = TTY::Font.new(:starwars)
PASTEL = Pastel.new
##^how to use the TTY-prompt gem##

require_all 'lib'
require_all 'app/models'
