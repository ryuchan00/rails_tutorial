class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    # 正規表現で、リプライユーザーを指定しているか
    reply_user = @micropost.content.match(/(^@|\s@|\W@)([a-zA-Z0-9]+)(\s|\n|$)/)[2]
    # 対象リプライユーザーがDBに存在するか
    if reply_user.present? and User.exists?(name: reply_user)
      # 対象ユーザーIDを取得するためにオブジェクトをfind_by
      reply_user_info = User.find_by(name: reply_user)
      # 対象ユーザーのIDを@micropostオブジェクトに代入
      @micropost.in_reply_to = reply_user_info.id
    end
    # 複数人に返信する場合はこれを使う
    # reply_users = @micropost.content.scan(/@([a-zA-Z0-9]+)\s/)
    # if reply_users.present?
    #   reply_users.each do |reply_user|
    #     p reply_user
    #     if User.exists?(name: reply_user[0].to_s) then
    #       @micropost.in_reply_to = true
          # debugger
        # else
          # debugger
          # reply_users.delete(reply_user)
        # end
      # end
    # end
    # debugger
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] == "Micropost deleted"
    # redirect_to request.referrer || root_url
    redirect_back(fallback_location: root_url)
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
