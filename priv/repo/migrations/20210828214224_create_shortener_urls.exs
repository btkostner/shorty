defmodule Shorty.Repo.Migrations.CreateShortenerUrls do
  use Ecto.Migration

  def change do
    create table(:shortener_urls) do
      add :url, :text

      timestamps()
    end

    create index(:shortener_urls, [:url], unique: true)
  end
end
