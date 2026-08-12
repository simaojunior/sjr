defmodule SjrWeb.Router do
  use SjrWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {SjrWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SjrWeb.Plugs.Locale
    plug SjrWeb.Plugs.VisitorCounter
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SjrWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/til", PageController, :til
    get "/uses", PageController, :uses
    get "/cv", PageController, :cv
    get "/posts/:id", BlogController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", SjrWeb do
  #   pipe_through :api
  # end
end
