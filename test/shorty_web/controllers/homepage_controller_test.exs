defmodule ShortyWeb.HomepageControllerTest do
  use ShortyWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "URL shortener"
  end

  test "POST / with no options", %{conn: conn} do
    conn = post(conn, "/")
    assert html_response(conn, 400) =~ "Invalid URL given"
  end

  test "POST / with bad options", %{conn: conn} do
    conn = post(conn, "/", %{"url" => %{"url" => "testing"}})
    assert html_response(conn, 400) =~ "is not a valid Url"
  end

  test "POST / with good options", %{conn: conn} do
    conn = post(conn, "/", %{"url" => %{"url" => "http://example.com"}})
    assert html_response(conn, 200) =~ "http://localhost:4002/"
  end
end
