require_relative "mixtape"

file_name = "mixtape.json"
@mixtape = Mixtape.new(file_name)

def red(string)
  "\e[31m#{string}\e[0m"
end

def green(string)
  "\e[32m#{string}\e[0m"
end

def assert(value)
  return print(green(".")) if value
  print red("F")
  p caller(1..1).first
end

assert @mixtape.is_a?(Mixtape)

def test_users_hash
  assert @mixtape.users_hash.is_a?(Hash)
  assert @mixtape.users_hash.any?
  assert @mixtape.users_hash.values.all?(User)
end
test_users_hash

def test_playlists
  assert @mixtape.playlists.is_a?(Array)
  assert @mixtape.playlists.any?
  assert @mixtape.playlists.all?(Playlist)
  playlist = @mixtape.playlists.first
  assert playlist.user.is_a?(User)
  assert playlist.songs.first.is_a?(Song)
end
test_playlists

def test_songs_hash
  assert @mixtape.songs_hash.is_a?(Hash)
  assert @mixtape.songs_hash.any?
  assert @mixtape.songs_hash.values.all?(Song)
end
test_songs_hash

def test_add_playlist
  playlist_sizes = @mixtape.playlists.size
  @mixtape.add_playlist("changes.json")
  assert @mixtape.playlists.size == playlist_sizes + 1
  new_playlist = @mixtape.playlists.last
  assert !!new_playlist.id
  assert new_playlist.user.name == "Kim Malcom"

  first_song, second_song = new_playlist.songs
  assert !!first_song.id
  assert first_song.artist == "Taylor Swift"
  assert first_song.title == "This is me trying"

  assert !!second_song.id
  assert second_song.artist == "Lake Street Dive"
  assert second_song.title == "Mistakes"
end
test_add_playlist

def test_remove_playlists
  playlist_sizes = @mixtape.playlists.size
  @mixtape.remove_playlists("changes.json")
  assert @mixtape.playlists.size == playlist_sizes - 2
end
test_remove_playlists

def test_add_existing_song_to_existing_playlist
  playlist = @mixtape.playlists.find { |pl| pl.id == "2" }
  song_count = playlist.songs.count
  assert playlist.songs.last.id != "16"
  @mixtape.add_existing_song_to_existing_playlist("changes.json")
  playlist = @mixtape.playlists.find { |pl| pl.id == "2" }
  assert playlist.songs.count == song_count + 1
  assert playlist.songs.last.id == "16"
end
test_add_existing_song_to_existing_playlist
