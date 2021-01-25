require 'sqlite3'
require 'singleton'
require_relative 'users'
require_relative 'questions'
require_relative 'replies'
require_relative 'questionlikes'
require_relative 'questionfollows'

class QuestionsDBConnection < SQLite3::Database
    include Singleton
    
    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end