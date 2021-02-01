require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    unless @columns #check if columns already exists, if it doesn't...
      result = DBConnection.execute2(<<-SQL)
        SELECT
          *
        FROM
          #{self.table_name}
      SQL
      @columns = result[0].map(&:to_sym)
    else # if columns does exist...
      @columns
    end
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column.to_s) do
        self.attributes[column]
      end

      define_method(column.to_s + "=") do |new_value|
        self.attributes[column] = new_value
      end
    end

    @attributes
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.tableize
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      unless self.class.columns.include?(attr_name.to_sym)
        raise ArgumentError.new("unknown attribute '#{attr_name}'")
      else
        self.send(attr_name.to_s + "=", value)
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
