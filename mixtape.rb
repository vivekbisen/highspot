%w[playlist song user].each { |f| require_relative f }
require "json"

class Mixtape
  def initialize(mixtape = "")
    @mixtape = read_file(mixtape)
    @user_store = @mixtape.dig("users")
    @song_store = @mixtape.dig("songs")
    @playlist_store = @mixtape.dig("playlists")
  end

  def users_hash
    users_hash = {}
    # return users_hash unless users_hash.empty?
    @user_store.each do |user_param|
      users_hash[user_param["id"]] = User.new(user_param)
    end
    users_hash
  end

  def songs_hash
    songs_hash = {}
    # return songs_hash unless songs_hash.empty?
    @song_store.each do |song_param|
      songs_hash[song_param["id"]] = Song.new(song_param)
    end
    songs_hash
  end

  def playlists_hash
    playlists_hash = {}
    @playlist_store.each do |playlist_param|
      playlists_hash[playlist_param["id"]] =
        Playlist.new(
          "id" => playlist_param["id"],
          "user" => users_hash[playlist_param["user_id"]],
          "songs" => songs_hash.values_at(*playlist_param["song_ids"])
        )
    end
    playlists_hash
  end

  def playlists
    playlists_hash.values
  end

  def add_playlist(new_playlist_input_file)
    new_playlist_hash = read_file(new_playlist_input_file)
    user = User.new(
      "id" => new_id(users_hash),
      "name" => new_playlist_hash["user"]["name"]
    )
    @user_store.push(user.to_h)

    songs = new_playlist_hash["songs"].map { |song_hash|
      song = Song.new(
        "id" => new_id(songs_hash),
        "artist" => song_hash["artist"],
        "title" => song_hash["title"]
      )
      @song_store.push(song.to_h)
      song
    }

    playlist = Playlist.new(
      "id" => new_id(playlists_hash),
      "user" => user,
      "songs" => songs
    )

    @playlist_store.push(playlist.to_h)
  end

  private def new_id(hash)
    (hash.keys.map(&:to_i).max + 1).to_s
  end

  private def read_file(input_file)
    JSON.parse(File.read(input_file))
  end
end
