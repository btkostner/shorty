defmodule ShortyWeb.HomepageController do
  use ShortyWeb, :controller

  alias Shorty.Shortener

  def index(conn, _params) do
    changeset = Shortener.change_url(%Shortener.Url{})
    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"url" => url}) do
    case Shortener.create_url(url) do
      {:ok, url} ->
        render(conn, "show.html", url: url)

      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render("index.html", changeset: changeset)
    end
  end

  def create(conn, params) do
    conn
    |> put_flash(:error, "Invalid URL given")
    |> put_status(400)
    |> index(params)
  end
end
