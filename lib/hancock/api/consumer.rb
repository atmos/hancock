module Hancock
  module API
    module Consumers
      class App < JSON::App
        get '/consumers.json' do
          Hancock::Consumer.all.map { |consumer| consumer.attributes_for_api }.to_json
        end

        get '/consumers/:id.json' do |id|
          consumer = Hancock::Consumer.get(id)
          consumer.to_json
        end

        post '/consumers.json' do
          consumer = Hancock::Consumer.create_from_params(params)
          consumer.to_json
        end

        put '/consumers/:id.json' do |id|
          consumer = Hancock::Consumer.get(id)
          consumer.update_from_params(params)
          consumer.to_json
        end

        delete '/consumers/:id.json' do |id|
          consumer = Hancock::Consumer.get(id)
          consumer.destroy unless user.admin?
          consumer.to_json
        end
      end
    end
  end
end
