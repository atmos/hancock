module Hancock
  module API
    module Consumers
      class App < Sinatra::Base
        use Rack::AcceptFormat
        enable :methodoverride

        get '/consumers.json' do
          Hancock::Consumer.all.map { |user| user.attributes_for_api }.to_json
        end

        get '/consumers/:id.json' do |id|
          user = Hancock::Consumer.get(id)
          user.to_json
        end

        post '/consumers.json' do
          user = Hancock::Consumer.signup(params)
          user.to_json
        end

        put '/consumers/:id.json' do |id|
          user = Hancock::Consumer.get(id)
          user.update_from_params(params)
          user.to_json
        end

        delete '/consumers/:id.json' do |id|
          user = Hancock::Consumer.get(id)
          user.destroy unless user.admin?
          user.to_json
        end
      end
    end
  end
end
