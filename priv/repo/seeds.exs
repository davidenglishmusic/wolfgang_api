# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     WolfgangApi.Repo.insert!(%WolfgangApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias WolfgangApi.Repo
alias WolfgangApi.Directory.Album

Repo.insert!(%Album{
  title: "Atlantic Fiddles",
  album_artist: "",
  composer: "",
  genre: "Country & Folk"
})

Repo.insert!(%Album{
  title: "Bach: Goldberg Variations (1981 Recording)",
  album_artist: "Glenn Gould",
  composer: "Johannes Sebastian Bach",
  genre: "Classical"
})

Repo.insert!(%Album{
  title: "Shostakovich: Quartets ",
  album_artist: "St. Lawrence String Quartet",
  composer: "Dmitri Shostakovich",
  genre: "Classical"
})
