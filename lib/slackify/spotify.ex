defmodule Slackify.Spotify do
  # TODO: Replace all of this with https://github.com/jsncmgs1/spotify_ex
  # Currently it doesn't support the endpoint we care about

  @moduledoc "Our wrapper around the bits of the Spotify API we care about"

  @accounts_base "https://accounts.spotify.com"
  @authorize_endpoint "authorize"
  @code_exchange_endpoint "api/token"

  @api_base "https://api.spotify.com"
  @now_playing_endpoint "v1/me/player/currently-playing"

  def generate_authorization_url do
    @accounts_base <> "/" <> @authorize_endpoint <> "?" <> URI.encode_query(_authorization_url_params())
  end

  def exchange_code_for_refresh_token(code) do
    {:ok, response} = HTTPoison.post(
      URI.merge(@accounts_base, @code_exchange_endpoint),
      {:form, _refresh_token_exchange_body(code)},
      %{},
      [hackney: [basic_auth: {System.get_env("SPOTIFY_CLIENT_ID"), System.get_env("SPOTIFY_CLIENT_SECRET")}]]
    )

    case Poison.Parser.parse!(response.body)["refresh_token"] do
      nil -> raise RuntimeError, message: "Couldn't get refresh token, body: " <> response.body
      refresh_token -> refresh_token
    end
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

  def _refresh_token_exchange_body(code) do
    [
      grant_type: "authorization_code",
      code: code,
      redirect_uri: System.get_env("SPOTIFY_REDIRECT_URL")
    ]
  end
end
