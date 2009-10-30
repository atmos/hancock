module Hancock
  class Model
    def self.attributes_for_api; [ ]; end
    def attributes_for_update; [ ]; end

    def attributes_for_api
      result = { }
      self.class.attributes_for_api.each do |key|
        result[key] = self.send(key)
      end
      result
    end

    def to_json
      attributes_for_api.to_json
    end

    def update_from_params(params)
      attributes_for_update.each do |key|
        self.send("#{key}=", params[key]) if params[key]
      end
    end
  end
end
