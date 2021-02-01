class AttrAccessorObject
  def self.my_attr_accessor(*names)
    # ...
    names.each do |name|
      name = name.to_s

      define_method(name) do
        instance_variable_get("@" + name)
      end

      define_method(name + "=") do |new_value|
        instance_variable_set("@" + name, new_value)
      end
    end
  end
end
