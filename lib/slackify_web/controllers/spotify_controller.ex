defmodule SlackifyWeb.SpotifyController do
  use SlackifyWeb, :controller

  def handle_redirect(conn, _params) do
    text conn, "Successfully authorized with Spotify"
  end
end
