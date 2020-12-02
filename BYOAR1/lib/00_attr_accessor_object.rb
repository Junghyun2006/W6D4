class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method(name) do 
        return self.instance_variable_get('@'+name.to_s)
      end
      define_method(name.to_s+"=") do |input|
        self.instance_variable_set("@#{name}", input)
      end
    end
    nil
  end

end
