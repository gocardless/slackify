defmodule Slackify.Spotify do
  @moduledoc "Our wrapper around the bits of the Spotify API we care about"

  @spotify_api_base "https://api.spotify.com/"
  @now_playing_endpoint "v1/me/player/currently-playing"

  def get_current_track(access_token) do
    HTTPoison.get(
      URI.merge(@spotify_api_base, @now_playing_endpoint),
      [{"Authorization", "Bearer " <> access_token}]
    )
  end
end
