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
        render(conn, "index.html", changeset: changeset)
    end
  end

  def create(conn, params) do
    conn
    |> put_flash(:error, "Invalid URL given")
    |> index(params)
  end
end
