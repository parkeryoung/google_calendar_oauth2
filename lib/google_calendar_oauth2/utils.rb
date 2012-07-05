module GoogleCalendar
  module Utils    
    def to_s
      class_name = "#&lt;#{self.class} "
      vars = []
      self.instance_variables.each do |var|
        name = var
        var = var.to_s
        var['@'] = ''
        vars << "#{var}:#{self.instance_variable_get(name)}"
      end
      class_name+vars.join(', ')+"&gt;"
    end
  end
end