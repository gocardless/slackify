defmodule SlackifyWeb.PageController do
  use SlackifyWeb, :controller

  def index(conn, _params) do
    user_id = get_session(conn, :slack_user_id)
    render conn, "index.html", user_id: user_id, has_spotify: false
  end
end
