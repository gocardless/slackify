defmodule SlackifyWeb.SpotifyController do
  use SlackifyWeb, :controller

  def handle_redirect(conn, params) do
    refresh_token = Slackify.Spotify.exchange_code_for_refresh_token(params["code"])
    access_token = Slackify.Spotify.exchange_refresh_token_for_access_token(refresh_token)
    now_playing = Slackify.Spotify.get_current_track(access_token)["item"]

    track_string = Enum.at(now_playing["artists"], 0)["name"] <> " - " <> now_playing["name"]

    text conn, track_string
  end
end
