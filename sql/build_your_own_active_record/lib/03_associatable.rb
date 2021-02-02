require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.to_s.singularize.camelize.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @class_name = options[:class_name] || name.to_s.singularize.camelize
    @foreign_key = options[:foreign_key] || (name.to_s.downcase.singularize + "_id").to_sym
    @primary_key = options[:primary_key] || :id
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @class_name = options[:class_name] || name.to_s.singularize.camelize
    @foreign_key = options[:foreign_key] || (self_class_name.to_s.downcase.singularize + "_id").to_sym
    @primary_key = options[:primary_key] || :id
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name = name, options = options)
    define_method(name.to_s) do
      value = self.send(options.foreign_key.to_s)
      options.model_class.where({ options.primary_key => value }).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name = name, self_class_name = self.name, options = options)
    define_method(name.to_s) do
      value = self.send(options.primary_key.to_s)
      options.model_class.where({ options.foreign_key => value })
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
