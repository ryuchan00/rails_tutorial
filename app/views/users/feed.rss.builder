xml.instruct! :xml, :version => "1.0"
xml.rss("version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/") do
  xml.channel do
    xml.title 'sample_app'
    xml.description "#{@user.name}のページ"
    xml.link ENV['DOMAIN']
    @microposts.each do |m|
      xml.item do
        xml.title "#{@user.name}さんの発言 #{m.created_at.to_s(:jp)}"
        xml.description do
          xml.cdata! m.content
        end
        xml.pubDate m.created_at
        xml.enclosure :url => (gravatar_for_url @user), :length => 100, :type => 'image/png'
        xml.guid "#{ENV['DOMAIN']}/users/#{@user.id}"
        xml.link "#{ENV['DOMAIN']}/users/#{@user.id}"
      end
    end
  end
end
