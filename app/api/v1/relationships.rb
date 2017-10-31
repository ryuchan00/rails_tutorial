module V1
  class Relationships < Grape::API
    version 'v1', using: :param, parameter: 'client_id_token' 'client_secret_token' 'followed_id'
    # version 'v1', using: :path, parameter: 'client_id_token'
    format :json
    prefix :api

    resource :relationships do
      post do

      end

      delete do

      end
    end
  end
end
