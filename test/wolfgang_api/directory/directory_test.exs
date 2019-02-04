defmodule WolfgangApi.DirectoryTest do
  use WolfgangApi.DataCase

  alias WolfgangApi.Directory

  describe "albums" do
    alias WolfgangApi.Directory.Album

    @valid_attrs %{album_artist: "some album_artist", composer: "some composer", genre: "some genre", title: "some title"}
    @update_attrs %{album_artist: "some updated album_artist", composer: "some updated composer", genre: "some updated genre", title: "some updated title"}
    @invalid_attrs %{album_artist: nil, composer: nil, genre: nil, title: nil}

    def album_fixture(attrs \\ %{}) do
      {:ok, album} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_album()

      album
    end

    test "list_albums/0 returns all albums" do
      album = album_fixture()
      assert Directory.list_albums() == [album]
    end

    test "get_album!/1 returns the album with given id" do
      album = album_fixture()
      assert Directory.get_album!(album.id) == album
    end

    test "create_album/1 with valid data creates a album" do
      assert {:ok, %Album{} = album} = Directory.create_album(@valid_attrs)
      assert album.album_artist == "some album_artist"
      assert album.composer == "some composer"
      assert album.genre == "some genre"
      assert album.title == "some title"
    end

    test "create_album/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_album(@invalid_attrs)
    end

    test "update_album/2 with valid data updates the album" do
      album = album_fixture()
      assert {:ok, %Album{} = album} = Directory.update_album(album, @update_attrs)
      assert album.album_artist == "some updated album_artist"
      assert album.composer == "some updated composer"
      assert album.genre == "some updated genre"
      assert album.title == "some updated title"
    end

    test "update_album/2 with invalid data returns error changeset" do
      album = album_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_album(album, @invalid_attrs)
      assert album == Directory.get_album!(album.id)
    end

    test "delete_album/1 deletes the album" do
      album = album_fixture()
      assert {:ok, %Album{}} = Directory.delete_album(album)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_album!(album.id) end
    end

    test "change_album/1 returns a album changeset" do
      album = album_fixture()
      assert %Ecto.Changeset{} = Directory.change_album(album)
    end
  end
end
