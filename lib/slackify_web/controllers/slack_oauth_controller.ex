defmodule SlackifyWeb.SlackOAuthController do
  use SlackifyWeb, :controller
  
  def create(conn, _params) do
    redirect conn, external: Slack.authorize_url!()
  end

  def callback(conn, %{"code" => code}) do
    client = Slack.get_token!(code: code)
    IO.inspect client
    conn
    |> send_resp(200, "hello world")
  end

  defp host do
    Application.fetch_env!(:slackify, SlackifyWeb.Endpoint)[:url][:host]
  end

  # def port do
  #   to_string(Application.fetch_env!(:slackify, SlackifyWeb.Endpoint)[:url][:port])
  # end
  defp redirect_uri do
    host() <> "/slack/callback"
  end
end