module Hancock
  module API
    class App < Sinatra::Base
      use Rack::AcceptFormat

      get '/users.json' do
        Hancock::User.all.map { |user| user.api_attributes }.to_json
      end

      get '/users/:id.json' do |id|
        Hancock::User.get(id).to_json
      end
    end
  end
end
