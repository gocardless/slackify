defmodule Slackify.Spotify do
  @moduledoc "Our wrapper around the bits of the Spotify API we care about"

  @accounts_base "https://accounts.spotify.com"
  @authorize_endpoint "authorize"

  @api_base "https://api.spotify.com"
  @now_playing_endpoint "v1/me/player/currently-playing"

  def generate_authorization_url do
    @accounts_base <> "/" <> @authorize_endpoint <> "?" <> URI.encode_query(_authorization_url_params())
  end

  def get_current_track(access_token) do
    HTTPoison.get(
      URI.merge(@api_base, @now_playing_endpoint),
      [{"Authorization", "Bearer " <> access_token}]
    )
  end

  def _authorization_url_params do
    %{
      "client_id" => System.get_env("SPOTIFY_CLIENT_ID"),
      "response_type" => "code",
      "redirect_uri" => System.get_env("SPOTIFY_REDIRECT_URL"),
      "scope" => "user-read-currently-playing"
    }
  end
end
