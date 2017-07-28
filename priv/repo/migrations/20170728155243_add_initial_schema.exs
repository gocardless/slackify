defmodule Slackify.Repo.Migrations.AddInitialSchema do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :slack_id, :string, primary_key: true
      add :slack_access_token, :string
      add :spotify_refresh_token, :string

      timestamps()
    end
  end
end
