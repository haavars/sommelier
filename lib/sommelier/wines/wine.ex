defmodule Sommelier.Wines.Wine do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wines" do
    field :name, :string
    field :url, :string
    field :embedding, :binary

    timestamps()
  end

  @doc false
  def changeset(wine, attrs) do
    wine
    |> cast(attrs, [:name, :url, :embedding])
    |> validate_required([:name, :url, :embedding])
  end
end
