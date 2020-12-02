require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    @query ||= DBConnection.execute2(<<-SQL)[0].map(&:to_sym)
      SELECT
        *
      FROM
        #{self.table_name}
      LIMIT(0)
      SQL
  end

  def self.finalize!
    self.columns.each do |col|
       my_attr_accessor(col)
    end
  end

  def self.table_name=(table_name)
      instance_variable_set("@#{self.table_name}", table_name)
  end

  def self.table_name
      class_name = self.to_s
      result = class_name.chars.map {|char| char == char.upcase ? '_' + char.downcase : char}.join('') + 's'
      result[1..-1]
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

  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method(name) do 
        self.attributes[name.to_sym]
      end 
    
      define_method(name.to_s+"=") do |input = nil|
        self.attributes[name.to_sym] = input
      end
    end
    nil
  end

end
