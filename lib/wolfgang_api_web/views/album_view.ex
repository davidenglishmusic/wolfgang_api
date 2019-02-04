defmodule WolfgangApiWeb.AlbumView do
  use WolfgangApiWeb, :view
  alias WolfgangApiWeb.AlbumView

  def render("index.json", %{albums: albums}) do
    %{data: render_many(albums, AlbumView, "album.json")}
  end

  def render("show.json", %{album: album}) do
    %{data: render_one(album, AlbumView, "album.json")}
  end

  def render("album.json", %{album: album}) do
    %{id: album.id,
      title: album.title,
      album_artist: album.album_artist,
      composer: album.composer,
      genre: album.genre}
  end
end
