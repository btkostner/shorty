defmodule Shorty.Shortener do
  @moduledoc """
  The Shortener context. It's responsible for storing shortened URLs and
  retreving them later.

  TODO: We should add a cache layer here because we can.
  """

  alias Shorty.Repo
  alias Shorty.Shortener.Url

  @doc """
  Returns the list of urls.

  ## Examples

      iex> list_urls()
      [%Url{}, ...]

  """
  def list_urls do
    Url
    |> Repo.all()
    |> Url.populate_hash()
  end

  @doc """
  Gets a single url by the integer ID.

  Raises `Ecto.NoResultsError` if the Url does not exist.

  ## Examples

      iex> get_url_by_id!(123)
      %Url{}

      iex> get_url_by_id!(456)
      ** (Ecto.NoResultsError)

  """
  def get_url_by_id!(id) do
    Url
    |> Repo.get!(id)
    |> Url.populate_hash()
  end

  @doc """
  Gets a single url by the integer ID.

  Raises `Ecto.NoResultsError` if the Url does not exist.

  ## Examples

      iex> get_url_by_hash!("B6VB")
      %Url{}

      iex> get_url_by_hash!("NO")
      ** (Ecto.NoResultsError)

  """
  def get_url_by_hash!(hash) do
    if id = Url.decode_hash(hash) do
      Url
      |> Repo.get!(id)
      |> Url.populate_hash()
    else
      raise Ecto.NoResultsError, queryable: Url
    end
  end

  @doc """
  Creates a url. This is considered a no-op if the `url` field already exists
  in the database, and will instead return the original record.

  ## Examples

      iex> create_url(%{field: value})
      {:ok, %Url{}}

      iex> create_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_url(attrs \\ %{}) do
    changeset = Url.changeset(%Url{}, attrs)
    url_value = Ecto.Changeset.get_field(changeset, :url)

    # With Postgres, we require an update on conflict to return the `id` field,
    # which is needed to generate the `hash` field. We have to manually set a
    # no-op update here instead of `:update_all` because that would result in
    # the `id` field also being regenerated, and a new `hash` for the url being
    # in use.
    on_conflict = [set: [url: url_value]]

    changeset
    |> Repo.insert(returning: true, on_conflict: on_conflict, conflict_target: :url)
    |> Url.populate_hash()
  end

  @doc """
  Updates a url.

  ## Examples

      iex> update_url(url, %{field: new_value})
      {:ok, %Url{}}

      iex> update_url(url, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_url(%Url{} = url, attrs) do
    url
    |> Url.changeset(attrs)
    |> Repo.update()
    |> Url.populate_hash()
  end

  @doc """
  Deletes a url.

  ## Examples

      iex> delete_url(url)
      {:ok, %Url{}}

      iex> delete_url(url)
      {:error, %Ecto.Changeset{}}

  """
  def delete_url(%Url{} = url) do
    url
    |> Repo.delete()
    |> Url.populate_hash()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking url changes.

  ## Examples

      iex> change_url(url)
      %Ecto.Changeset{data: %Url{}}

  """
  def change_url(%Url{} = url, attrs \\ %{}) do
    Url.changeset(url, attrs)
  end
end
