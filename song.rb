class Song
  attr_reader :id, :artist, :title

  def initialize(params)
    @params = params
    @id = params["id"]
    @artist = params["artist"]
    @title = params["title"]
  end

  def to_h
    @params
  end
end
