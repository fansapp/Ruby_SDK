module OptimalPayments
  class JsonObject


    def initialize args
      args.each do |key, value|
        self.instance_variable_set("@#{key}".to_sym, value)
      end
    end

    def get required=[], ignore=[]
      vars = {}
      instance_variables.map do |name|
        s = name.to_s
        s[0] = ""
        if !ignore.include?(s) and (!instance_variable_get(name).nil? or required.include?(s))
          vars[s] = instance_variable_get(name)
        end
      end
      vars
    end
  end
end