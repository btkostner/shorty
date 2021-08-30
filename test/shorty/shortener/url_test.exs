defmodule Shorty.Shortener.UrlTest do
  use Shorty.DataCase

  alias Shorty.Shortener.Url

  describe "changeset/2" do
    test "validates url required" do
      changeset = Url.changeset(%Url{}, %{})
      assert "can't be blank" in errors_on(changeset).url
    end

    test "validates url requires allowed scheme" do
      assert %{valid?: true} = Url.changeset(%Url{}, %{"url" => "https://example.com"})
      assert %{valid?: true} = Url.changeset(%Url{}, %{"url" => "http://example.com"})

      changeset = Url.changeset(%Url{}, %{"url" => "ssh://example.com"})
      assert "scheme not allowed" in errors_on(changeset).url
    end

    test "validates url requires a host" do
      assert %{valid?: true} = Url.changeset(%Url{}, %{"url" => "https://example.com"})

      changeset = Url.changeset(%Url{}, %{"url" => "https://"})
      assert "must include a host" in errors_on(changeset).url
    end
  end
end
