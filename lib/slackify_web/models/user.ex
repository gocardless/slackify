defmodule Slackify.User do
  use Ecto.Schema

  @primary_key false
  schema "users" do
    field :slack_id, :string, primary_key: true
    field :slack_access_token, :string
    field :spotify_refresh_token, :string

    timestamps
  end

end
