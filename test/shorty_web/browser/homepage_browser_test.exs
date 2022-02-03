defmodule ShortyWeb.HomepageBrowserTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  @input_field Query.css("input")
  @submit_button Query.css("button[type=\"submit\"]")

  feature "auto adds https:// when typing a url", %{session: session} do
    session
    |> visit("/")
    |> find(Query.css("body"))
    |> IO.inspect(label: "body")
    |> fill_in(@input_field, with: "example.com")
    |> assert_text(@input_field, "https://example.com")
  end
end
