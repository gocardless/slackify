defmodule SlackifyWeb.SlackOAuthController do
  use SlackifyWeb, :controller
  
  def create(conn, _params) do
    redirect conn, external: Slack.authorize_url!()
  end

  def callback(conn, %{"code" => code}) do
    client = Slack.get_token!(code: code)
    IO.inspect client
    conn = put_session(conn, :slack_user_id, client.token.other_params["user_id"])
    redirect conn, to: "/"
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