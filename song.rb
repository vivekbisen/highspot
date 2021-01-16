class Song
  attr_reader :id, :artist, :title

  def initialize(id:, artist:, title:)
    @id, @artist, @title = id, artist, title
  end
end
