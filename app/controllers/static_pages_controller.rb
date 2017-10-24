class StaticPagesController < ApplicationController
  def home
    #  1行のときは後置if文、2行以上のときは前置if文を使うのがRubyの慣習です。
    # @micropost = current_user.microposts.build if logged_in?
    if logged_in?
      @micropost = current_user.microposts.build
      feed_items = current_user.feed.paginate(page: params[:page])
      @feed_items = feed_items
      n = 0
      feed_items.each do |feed_item|
        p feed_item.content
        # 正規表現で、リプライユーザーを指定しているか
        # reply_user = feed_item.content.match(/(^@|\s@|\W@)([a-zA-Z0-9]+)(\s|\n|$)/)[2]
        # 対象リプライユーザーがDBに存在するか
        # if reply_user.present? and User.exists?(name: reply_user)
          # 対象ユーザーIDを取得するためにオブジェクトをfind_by
          # reply_user_info = User.find_by(name: reply_user)
        p feed_item.in_reply_to
        if feed_item.in_reply_to != nil
          reply_user = User.find(feed_item.in_reply_to)
          # 対象ユーザーのIDを@micropostオブジェクトに代入
          @feed_items[n].content.gsub!("@#{reply_user.name}", "<a href=\"/users/#{feed_item.in_reply_to}\" target=\"blank\">@#{reply_user.name}</a>")
          n = n +1
          # debugger
        end
      end
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
