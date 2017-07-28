defmodule SlackifyWeb.Router do
  use SlackifyWeb, :router
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SlackifyWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/slack", SlackOAuthController, :create
    get "/slack/callback", SlackOAuthController, :callback

    get "/spotify_redirect", SpotifyController, :handle_redirect
  end

  # Other scopes may use custom stacks.
  # scope "/api", SlackifyWeb do
  #   pipe_through :api
  # end
end
