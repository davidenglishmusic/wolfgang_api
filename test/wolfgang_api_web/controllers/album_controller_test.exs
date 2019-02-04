defmodule WolfgangApiWeb.AlbumControllerTest do
  use WolfgangApiWeb.ConnCase

  alias WolfgangApi.Directory
  alias WolfgangApi.Directory.Album

  @create_attrs %{
    album_artist: "some album_artist",
    composer: "some composer",
    genre: "some genre",
    title: "some title"
  }
  @update_attrs %{
    album_artist: "some updated album_artist",
    composer: "some updated composer",
    genre: "some updated genre",
    title: "some updated title"
  }
  @invalid_attrs %{album_artist: nil, composer: nil, genre: nil, title: nil}

  def fixture(:album) do
    {:ok, album} = Directory.create_album(@create_attrs)
    album
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all albums", %{conn: conn} do
      conn = get(conn, Routes.album_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create album" do
    test "renders album when data is valid", %{conn: conn} do
      conn = post(conn, Routes.album_path(conn, :create), album: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.album_path(conn, :show, id))

      assert %{
               "id" => id,
               "album_artist" => "some album_artist",
               "composer" => "some composer",
               "genre" => "some genre",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.album_path(conn, :create), album: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update album" do
    setup [:create_album]

    test "renders album when data is valid", %{conn: conn, album: %Album{id: id} = album} do
      conn = put(conn, Routes.album_path(conn, :update, album), album: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.album_path(conn, :show, id))

      assert %{
               "id" => id,
               "album_artist" => "some updated album_artist",
               "composer" => "some updated composer",
               "genre" => "some updated genre",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, album: album} do
      conn = put(conn, Routes.album_path(conn, :update, album), album: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete album" do
    setup [:create_album]

    test "deletes chosen album", %{conn: conn, album: album} do
      conn = delete(conn, Routes.album_path(conn, :delete, album))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.album_path(conn, :show, album))
      end
    end
  end

  defp create_album(_) do
    album = fixture(:album)
    {:ok, album: album}
  end
end
