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
        if feed_item.in_reply_to != nil
          reply_user = User.find(feed_item.in_reply_to)
          @feed_items[n].content.gsub!("@#{reply_user.name}", "<a href=\"/users/#{feed_item.in_reply_to}\" target=\"blank\">@#{reply_user.name}</a>")
          n = n +1
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
