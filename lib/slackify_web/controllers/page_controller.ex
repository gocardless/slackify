defmodule SlackifyWeb.PageController do
  use SlackifyWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
