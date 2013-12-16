require "open-uri"

class Video_Scraper
  attr_reader :html

  def initialize(artist, song)
    url = "https://gdata.youtube.com/feeds/api/videos?q=#{artist}+#{song}"
    @html = Nokogiri::HTML(open(url))
  end

  def video
    @html.xpath("//content")[1].attributes["url"].value
  end
end 