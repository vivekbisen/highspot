class Playlist
  attr_reader :id, :user_id, :song_ids

  def initialize(id:, user_id:, song_ids: [])
    @id, @user_id, @song_ids = id, user_id, song_ids
  end

  def add_songs(song_ids)
    @song_ids.push(*song_ids)
  end
end
