require_relative "mixtape"

file_name = "mixtape.json"
@mixtape = Mixtape.new(file_name)

def red(string)
  "\e[31m#{string}\e[0m"
end

def green(string)
  "\e[32m#{string}\e[0m"
end

def test(value)
  print value ? green(".") : red("F")
end

def test_mixtape
  @mixtape.is_a?(Mixtape)
end
test test_mixtape

def test_users
  @mixtape.users.is_a?(Array) &&
    @mixtape.users.all?(User)
end
test test_users

def test_playlists
  @mixtape.playlists.is_a?(Array) &&
    @mixtape.playlists.all?(Playlist)
end
test test_playlists

def test_songs
  @mixtape.songs.is_a?(Array) &&
    @mixtape.songs.all?(Song)
end
test test_songs

puts
