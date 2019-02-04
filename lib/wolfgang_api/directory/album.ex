defmodule WolfgangApi.Directory.Album do
  use Ecto.Schema
  import Ecto.Changeset


  schema "albums" do
    field :album_artist, :string
    field :composer, :string
    field :genre, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:title, :album_artist, :composer, :genre])
    |> validate_required([:title])
  end
end
