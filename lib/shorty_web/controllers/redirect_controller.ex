defmodule ShortyWeb.RedirectController do
  use ShortyWeb, :controller

  alias Shorty.Shortener

  def index(conn, %{"hash" => hash}) do
    url = Shortener.get_url_by_hash!(hash)

    # Because we have delete and update methods for urls (even though they are
    # not used), we are going to do a temporary redirect here instead.
    conn
    |> put_status(302)
    |> redirect(external: url.url)
  end
end
