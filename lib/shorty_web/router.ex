defmodule ShortyWeb.Router do
  use ShortyWeb, :router

  pipeline :interface do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_root_layout, {ShortyWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :put_root_layout, {ShortyWeb.LayoutView, :root}
    plug :put_secure_browser_headers
  end

  scope "/", ShortyWeb do
    pipe_through :interface

    get "/", HomepageController, :index
    post "/", HomepageController, :create
  end

  scope "/", ShortyWeb do
    pipe_through :browser

    get "/:hash", RedirectController, :index
  end
end
