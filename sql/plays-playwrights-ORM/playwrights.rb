require 'sqlite3'
require 'singleton'
require_relative 'plays'

class Playwright
    attr_accessor :id, :name, :birth_year

    def self.all
        data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
        data.map { |datum| Playwright.new(datum) }
    end

    def self.find_by_name(name)
        PlayDBConnection.instance.execute(<<-SQL, name)
            SELECT
                *
            FROM
                plays
            JOIN
                playwrights
            ON
                playwrights.id = plays.playwright_id
            WHERE
                playwrights.name = ?
        SQL
    end

    def initialize(options)
        @id = options['id']
        @name = options['name']
        @birth_year = options['birth_year']
    end

    def create
        raise "#{self} already in database" if self.id
        PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
            INSERT INTO
                playwrights (name, birth_year)
            VALUES
                (?, ?)
        SQL
        self.id = PlayDBConnection.instance.last_insert_row_id
    end

    def update
        raise "#{self} not in database" unless self.id
        PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year, self.id)
            UPDATE
                playwrights
            SET
                name = ?, birth_year = ?
            WHERE
                id = ?
        SQL
    end

    def get_plays
        PlayDBConnection.instance.execute(<<-SQL, self.name)
            SELECT
                *
            FROM
                plays
            JOIN
                playwrights
            ON
                playwrights.id = plays.playwright_id
            WHERE
                playwrights.name = ?
        SQL
    end
end