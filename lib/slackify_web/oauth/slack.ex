defmodule Slack do
  use OAuth2.Strategy

  def client do
    OAuth2.Client.new([
      strategy: __MODULE__,
      client_id: System.get_env("SLACK_CLIENT_ID"),
      client_secret: System.get_env("SLACK_CLIENT_SECRET"),
      site: "https://slack.com",
      redirect_uri: redirect_uri(),
      authorize_url: "https://slack.com/oauth/authorize",
      token_url: "https://slack.com/api/oauth.access",
    ])
  end

  # def port do
  #   to_string(Application.fetch_env!(:slackify, SlackifyWeb.Endpoint)[:url][:port])
  # end
  def authorize_url! do
    OAuth2.Client.authorize_url!(client(), scope: "users.profile:read,users.profile:write")
  end

  # you can pass options to the underlying http library via `opts` parameter
  def get_token!(params \\ [], headers \\ [], opts \\ []) do
    OAuth2.Client.get_token!(client(), params, headers, opts)
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_param(:client_secret, client.client_secret)
    |> put_header("accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end

  defp host do
    Application.fetch_env!(:slackify, SlackifyWeb.Endpoint)[:url][:host]
  end

  defp redirect_uri do
    host() <> "/slack/callback"
  end
end