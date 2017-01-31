class MovieEntry < Struct.new(:feed_entry)
  attr_accessor :title, :imdb_image, :download_url
  PUTIN ='http://www.gannett-cdn.com/-mm-/4eef18defffb11907f8d6e8e6522d28d8232b881/c=0-0-3719-2796&r=x408&c=540x405/local/-/media/2015/02/04/USATODAY/USATODAY/635586890584034737-AP-Russia-Putin.jpg'

  def title
    feed_entry.title
  end

  def imdb_url
    feed_entry.summary.split(' ').last.strip
  end

  def imdb_image
    @imdb_image ||= begin
      if imdb_url.starts_with?('http')
        object = LinkThumbnailer.generate(imdb_url)
        object.images.first.src.to_s
      else
        PUTIN
      end
    rescue
      PUTIN
    end
  end

  def download_url
    feed_entry.url
  end

end