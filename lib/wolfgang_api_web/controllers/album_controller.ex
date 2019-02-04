defmodule WolfgangApiWeb.AlbumController do
  use WolfgangApiWeb, :controller

  alias WolfgangApi.Directory
  alias WolfgangApi.Directory.Album

  action_fallback WolfgangApiWeb.FallbackController

  def index(conn, _params) do
    albums = Directory.list_albums()
    render(conn, "index.json", albums: albums)
  end

  def create(conn, %{"album" => album_params}) do
    with {:ok, %Album{} = album} <- Directory.create_album(album_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.album_path(conn, :show, album))
      |> render("show.json", album: album)
    end
  end

  def show(conn, %{"id" => id}) do
    album = Directory.get_album!(id)
    render(conn, "show.json", album: album)
  end

  def update(conn, %{"id" => id, "album" => album_params}) do
    album = Directory.get_album!(id)

    with {:ok, %Album{} = album} <- Directory.update_album(album, album_params) do
      render(conn, "show.json", album: album)
    end
  end

  def delete(conn, %{"id" => id}) do
    album = Directory.get_album!(id)

    with {:ok, %Album{}} <- Directory.delete_album(album) do
      send_resp(conn, :no_content, "")
    end
  end
end
