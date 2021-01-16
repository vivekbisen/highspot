class Playlist
  attr_reader :id, :user, :songs

  def initialize(params)
    @id = params["id"]
    @user = params["user"]
    @songs = params["songs"].to_a
  end

  def add_songs(songs)
    @songs.push(*songs)
  end

  def to_h
    {
      "id" => id,
      "user_id" => user.id,
      "song_ids" => songs.map(&:id)
    }
  end
end
