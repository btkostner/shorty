defmodule Shorty.ShortenerFixtures do
  @moduledoc """
  This module defines test helpers for creating entities via the
  `Shorty.Shortener` context. It uses `ExMachina.Ecto` for database operations.
  For more information, take a look at the `ExMachina` README:
  https://github.com/thoughtbot/ex_machina#readme
  """

  use ExMachina.Ecto, repo: Shorty.Repo

  alias Shorty.Shortener

  defdelegate populate_hash(url), to: Shortener.Url

  def url_factory do
    %Shortener.Url{
      url: sequence(:url, &"https://example.com/#{&1}")
    }
  end
end
