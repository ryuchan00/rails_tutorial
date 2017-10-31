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
          @user = User.where("id = #{user.id}").select(:id, :name, :email)
        else
          false
        end
        # client_id_token = params[:client_id_token]
        # client_secret_token = params[:client_secret_token]

        # user = User.find_by(client_id_token: client_id_token)
        # if user.present? and user.authenticated?(:client_secret, client_secret_token)
          # @user = User.where("id = #{user.id}").select(:id,:name)
          # @user = User.where("id = #{user.id}").select(:id, :name, :email)
          # params do
          #   requires :id, type: String, desc: 'User id.'
          # end
          # route_param :id do
          #   get do
          #     User.all
          #   end
          # end
          # add_swagger_documentation
        # else
        #   false
        # end
      end

      get :following do
        client_id_token = params[:client_id_token]
        client_secret_token = params[:client_secret_token]

        user = User.find_by(client_id_token: client_id_token)
        if user.present? and user.authenticated?(:client_secret, client_secret_token)
          user.following.select(:id, :name, :email)
        else
          false
        end
      end

      get :follower do
        client_id_token = params[:client_id_token]
        client_secret_token = params[:client_secret_token]

        user = User.find_by(client_id_token: client_id_token)
        if user.present? and user.authenticated?(:client_secret, client_secret_token)
          user.followers.select(:id, :name, :email)
        else
          false
        end
      end

      get :microposts do
        client_id_token = params[:client_id_token]
        client_secret_token = params[:client_secret_token]

        user = User.find_by(client_id_token: client_id_token)
        if user.present? and user.authenticated?(:client_secret, client_secret_token)
          user.microposts
        else
          false
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

# require 'grape-swagger'
#
# module V1
#   class Users < Grape::API
#     version 'v1', using: :path
#     format :json
#     prefix :api
#
#     resource :users do
#       get do
#         User.all
#       end
#
#       params do
#         requires :id, type: Integer, desc: 'User id.'
#       end
#       route_param :id do
#         get do
#           User.find(params[:id])
#         end
#       end
#     end
#   end
# end
#
