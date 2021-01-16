%w[playlist song user].each { |f| require_relative f }
require "json"

class Mixtape
  def initialize(mixtape = "")
    @mixtape = read_file(mixtape)
  end

  def users
    @mixtape.dig("users").map do |user|
      User.new(id: user["id"], name: user["name"])
    end
  end

  def songs
    @mixtape.dig("songs").map do |song|
      Song.new(
        id: song["id"],
        artist: song["artist"],
        title: song["title"]
      )
    end
  end

  def playlists
    @mixtape.dig("playlists").map do |playlist|
      Playlist.new(
        id: playlist["id"],
        user_id: playlist["user_id"],
        song_ids: playlist["song_ids"]
      )
    end
  end

  def read_file(input_file)
    JSON.parse(File.read(input_file))
  end
end
