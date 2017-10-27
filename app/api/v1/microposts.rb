module V1
  class Microposts < Grape::API
    version 'v1', using: :path, parameter: 'client_id_token'
    format :json
    prefix :api

    resource :microposts do
      get do
        # User.all
        user = User.find_by(client_id_token: params[:client_id_token])
        Micropost.find_by(user_id: user.id)
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
