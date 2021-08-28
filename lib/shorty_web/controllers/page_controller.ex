defmodule ShortyWeb.PageController do
  use ShortyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
