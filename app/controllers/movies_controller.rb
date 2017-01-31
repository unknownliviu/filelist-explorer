class MoviesController < ApplicationController
  def index
    @entries = []
  end

  def create
    url = params[:filelist_rss].strip
    @entries = begin
      Feedjira::Feed.fetch_and_parse(url).entries.first(50).compact
    rescue
      []
    end
    render 'index'
  end
end
