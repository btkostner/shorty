defmodule Shorty.Shortener.Url do
  @moduledoc """
  `Ecto.Schema` for storing shortened urls.
  """

  use Ecto.Schema

  import Ecto.Changeset

  @allowed_schemes ["https", "http"]
  @derive {Phoenix.Param, key: :hash}

  schema "shortener_urls" do
    field :url, :string
    field :hash, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:url])
    |> validate_required([:url])
    # This is 100% arbitrary. The underlying postgres does not have this limit.
    |> validate_length(:url, max: 8192)
    |> validate_change(:url, &validate_url/2)
    |> unique_constraint(:url)
  end

  defp validate_url(field, value) do
    # A lot of these requirements aren't necessarily technical, but to ensure
    # we only take reasonable Urls.
    case URI.parse(value) do
      %{host: nil, scheme: nil} ->
        Keyword.put([], field, "is not a valid Url")

      %{scheme: nil} ->
        Keyword.put([], field, "scheme required")

      # This one is actally is technical, because any other protocol probably
      # doesn't understand an http headers and what the redirect header does.
      %{scheme: scheme} when scheme not in @allowed_schemes ->
        Keyword.put([], field, "scheme not allowed")

      %{host: ""} ->
        Keyword.put([], field, "must include a host")

      # Anyone in control of a top level domain, really doesn't need a Url shortener.
      %{host: host} when is_binary(host) ->
        if String.contains?(host, "."),
          do: [],
          else: Keyword.put([], field, "can't be top level")

      _ ->
        []
    end
  end

  @doc """
  Adds the virtual `hash` field to `%Shorty.Shortener.Url{}`. This is ran after
  any database operation to ensure it's transparent to anything outside of the
  `Shorty.Shortener` context.
  """
  def populate_hash({:ok, url}), do: {:ok, populate_hash(url)}
  def populate_hash({:error, _} = res), do: res
  def populate_hash(urls) when is_list(urls), do: Enum.map(urls, &populate_hash/1)

  def populate_hash(%__MODULE__{id: id} = url) when not is_nil(id),
    do: %{url | hash: encode_hash(id)}

  def populate_hash(url), do: url

  @doc """
  Takes an integer ID and encodes it to a small hash.
  """
  def encode_hash(id), do: hash_id_ctx() |> :hashids.encode(id) |> to_string()

  @doc """
  Takes a hash and decodes it to the original integer ID.
  """
  def decode_hash(hash) do
    # This is a "bug" between erlang and elixir. The result shows as a charlist
    # when it's really just an int.
    [id] = :hashids.decode(hash_id_ctx(), String.to_charlist(hash))
    id
  rescue
    _ -> nil
  end

  defp hash_id_ctx(), do: :hashids.new(salt: hash_id_salt(), min_hash_length: 4)
  defp hash_id_salt(), do: :shorty |> Application.get_env(:hash_id_salt) |> String.to_charlist()
end
