defmodule Sommelier.WinesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sommelier.Wines` context.
  """

  @doc """
  Generate a wine.
  """
  def wine_fixture(attrs \\ %{}) do
    {:ok, wine} =
      attrs
      |> Enum.into(%{
        name: "some name",
        url: "some url",
        embedding: "some embedding"
      })
      |> Sommelier.Wines.create_wine()

    wine
  end
end
