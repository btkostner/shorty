defmodule ShortyWeb.ErrorViewTest do
  use ShortyWeb.ConnCase, async: true

  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(ShortyWeb.ErrorView, "404.html", []) =~ "Page Not Found"
  end

  test "renders 500.html" do
    assert render_to_string(ShortyWeb.ErrorView, "500.html", []) =~ "Internal Server Error"
  end
end
