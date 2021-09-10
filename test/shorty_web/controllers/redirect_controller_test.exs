defmodule ShortyWeb.RedirectControllerTest do
  use ShortyWeb.ConnCase

  import Shorty.ShortenerFixtures

  test "GET /:hash with valid hash", %{conn: conn} do
    url = insert(:url) |> populate_hash()
    conn = get(conn, "/#{url.hash}")
    assert redirected_to(conn, 302) == url.url
  end

  test "GET /:hash with invalid hash", %{conn: conn} do
    assert_error_sent :not_found, fn ->
      conn
      # This is needed for the error page to show correctly during tests due to
      # it not running in the pipeline
      |> Phoenix.Controller.put_layout({ShortyWeb.LayoutView, :root})
      |> post("/example")
    end
  end
end
