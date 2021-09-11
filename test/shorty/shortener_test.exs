defmodule Shorty.ShortenerTest do
  use Shorty.DataCase

  alias Shorty.Shortener

  import Shorty.ShortenerFixtures

  describe "urls" do
    alias Shorty.Shortener.Url

    @invalid_attrs %{url: nil}

    test "list_urls/0 returns all urls" do
      url = insert(:url) |> populate_hash()
      assert Shortener.list_urls() == [url]
    end

    test "get_url_by_id!/1 returns the url with given id" do
      url = insert(:url) |> populate_hash()
      assert Shortener.get_url_by_id!(url.id) == url
    end

    test "get_url_by_hash!/1 returns the url with given hash" do
      url = insert(:url) |> populate_hash()
      assert Shortener.get_url_by_hash!(url.hash) == url
    end

    test "get_url_by_hash!/1 raises Ecto.NoResultsError on decode failure" do
      assert_raise Ecto.NoResultsError, fn -> Shortener.get_url_by_hash!("no") end
    end

    test "create_url/1 with valid data creates a url" do
      valid_attrs = %{url: "https://example.com/create_url/1"}

      assert {:ok, %Url{} = url} = Shortener.create_url(valid_attrs)
      assert url.url == "https://example.com/create_url/1"
    end

    test "create_url/1 with already inserted url returns same hash" do
      %{hash: hash, url: url} = insert(:url) |> populate_hash()
      assert {:ok, %Url{hash: ^hash}} = Shortener.create_url(%{"url" => url})
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortener.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = insert(:url)
      update_attrs = %{url: "https://example.com/update_url/2"}

      assert {:ok, %Url{} = url} = Shortener.update_url(url, update_attrs)
      assert url.url == "https://example.com/update_url/2"
    end

    test "update_url/2 with invalid data returns error changeset" do
      url = insert(:url) |> populate_hash()
      assert {:error, %Ecto.Changeset{}} = Shortener.update_url(url, @invalid_attrs)
      assert url == Shortener.get_url_by_id!(url.id)
    end

    test "delete_url/1 deletes the url" do
      url = insert(:url)
      assert {:ok, %Url{}} = Shortener.delete_url(url)
      assert_raise Ecto.NoResultsError, fn -> Shortener.get_url_by_id!(url.id) end
    end

    test "change_url/1 returns a url changeset" do
      url = build(:url)
      assert %Ecto.Changeset{} = Shortener.change_url(url)
    end
  end
end
