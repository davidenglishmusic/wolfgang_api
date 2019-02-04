defmodule WolfgangApi.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :title, :string
      add :album_artist, :string
      add :composer, :string
      add :genre, :string

      timestamps()
    end

  end
end
