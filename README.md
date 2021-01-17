How to run
---
- Clone the repo. It contains `mixtape.json` and `changes.json`.
- There is `tests.rb` that has test examples. Running `bin/run_tests` script runs the test scenarios.
- If you want to add more test cases, feel free to follow the pattern:
```rb
def test_new_scenario
  file_name = "mixtape.json"
  changes_file_name = "changes.json"
  @mixtape = Mixtape.new(file_name)
  @mixtape.add_playlist(changes_file_name)
  # assert TEST CASES
  @mixtape.remove_playlists(changes_file_name)
  # assert TEST CASES
  @mixtape.add_existing_song_to_existing_playlist(changes_file_name)
  # assert TEST CASES
end
test_add_existing_song_to_existing_playlist

```

Explanation of the application
---
The approach I have taken in this exercise is a memory based datastore with caches in place which is very object oriented. I have defined objects for all the elements needed for this mixtape tree. Additionally, tests.rb tests the basic scenarios for all three methods.

Currently, a mixtape `has_many` playlists, a playlist `has_many` songs and `belongs_to` a user.

In order to implement a batch processing of this file, we can start requesting the data for the current context. For example, in order to delete/update a playlist of the mixtape, we can look for the playlist section of the data instead of processing the whole dataset. Gathering the ids of user and songs required for a specific playlist will reduce processing all three data stores I have created in the mixtape class.

Similarly, when changes file is huge, we can start looking at which operation we want to perform and only access the relevant data. Then going further into the context of playlist we need to deal with, we can access the subsequent user/song. In order to delete a playlist, we don't need to access the songs and user sections as they should persist independent of playlist because those might belong to other "active" playlists. Updating the record doesn't really need to add any changes to user and songs sections as long as the data relation is in place. Working with references in this way makes batching more logical and efficient.

Other than data relation, database implementation will definitely help in scaling this application. Once the file is read and data is populated, using the context of playlist, it rest of the dataset won't have to be touched.
