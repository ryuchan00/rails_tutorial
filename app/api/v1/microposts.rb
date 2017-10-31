module V1
  class Microposts < Grape::API
    version 'v1', using: :param, parameter: 'client_id_token' 'client_secret_token' 'content' 'micropost_id'
    # version 'v1', using: :path, parameter: 'client_id_token'
    format :json
    prefix :api

    resource :microposts do
      post do
        client_id_token = params[:client_id_token]
        client_secret_token = params[:client_secret_token]
        content = params[:content]

        user = User.find_by(client_id_token: client_id_token)
        if user.present? and user.authenticated?(:client_secret, client_secret_token)
          micropost = user.microposts.build
          micropost.content = content
          if micropost.content.match(/(^@|\s@|\W@)([a-zA-Z0-9]+)(\s|\n|$)/)
            reply_user = micropost.content.match(/(^@|\s@|\W@)([a-zA-Z0-9]+)(\s|\n|$)/)[2]
            if reply_user.present? and User.exists?(name: reply_user)
              reply_user_info = User.find_by(name: reply_user)
              micropost.in_reply_to = reply_user_info.id
            end
          end
          if micropost.save
            p micropost
          else
            p "Fail save"
          end
        else
          false
        end
      end

      delete do
        client_id_token = params[:client_id_token]
        client_secret_token = params[:client_secret_token]
        micropost_id = params[:micropost_id]

        user = User.find_by(client_id_token: client_id_token)
        if user.present? and user.authenticated?(:client_secret, client_secret_token)
          if micropost = Micropost.find_by(id: micropost_id, user_id: user.id)
            micropost.destroy
          else
            p "Micropost id or User id are not correct"
          end
        else
          false
        end
      end
    end
  end
end
