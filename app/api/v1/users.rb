module V1
  class Users < Grape::API
    # version 'v1', using: :path, parameter: 'client_id_token' 'client_secret_token'
    version 'v1', using: :param, parameter: 'client_id_token' 'client_secret_token'
    format :json
    prefix :api

    resource :users do
      get do
        client_id_token = params[:client_id_token]
        client_secret_token = params[:client_secret_token]

        user = User.find_by(client_id_token: client_id_token)
        if user.present? and user.authenticated?(:client_secret, client_secret_token)
          user
        else
          "false"
        end
      end

      # params do
      #   requires :id, type: Integer, desc: 'User id.'
      # end
      # route_param :id do
      #   get do
      #     User.find(params[:id])
      #     User.find_by(client_id_token: params[:client_id_token])
      #     # p params[:client_id_token]
      #   end
      # end
    end
  end
end
