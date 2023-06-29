defmodule Sommelier.WinesTest do
  use Sommelier.DataCase

  alias Sommelier.Wines

  describe "wines" do
    alias Sommelier.Wines.Wine

    import Sommelier.WinesFixtures

    @invalid_attrs %{name: nil, url: nil, embedding: nil}

    test "list_wines/0 returns all wines" do
      wine = wine_fixture()
      assert Wines.list_wines() == [wine]
    end

    test "get_wine!/1 returns the wine with given id" do
      wine = wine_fixture()
      assert Wines.get_wine!(wine.id) == wine
    end

    test "create_wine/1 with valid data creates a wine" do
      valid_attrs = %{name: "some name", url: "some url", embedding: "some embedding"}

      assert {:ok, %Wine{} = wine} = Wines.create_wine(valid_attrs)
      assert wine.name == "some name"
      assert wine.url == "some url"
      assert wine.embedding == "some embedding"
    end

    test "create_wine/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wines.create_wine(@invalid_attrs)
    end

    test "update_wine/2 with valid data updates the wine" do
      wine = wine_fixture()
      update_attrs = %{name: "some updated name", url: "some updated url", embedding: "some updated embedding"}

      assert {:ok, %Wine{} = wine} = Wines.update_wine(wine, update_attrs)
      assert wine.name == "some updated name"
      assert wine.url == "some updated url"
      assert wine.embedding == "some updated embedding"
    end

    test "update_wine/2 with invalid data returns error changeset" do
      wine = wine_fixture()
      assert {:error, %Ecto.Changeset{}} = Wines.update_wine(wine, @invalid_attrs)
      assert wine == Wines.get_wine!(wine.id)
    end

    test "delete_wine/1 deletes the wine" do
      wine = wine_fixture()
      assert {:ok, %Wine{}} = Wines.delete_wine(wine)
      assert_raise Ecto.NoResultsError, fn -> Wines.get_wine!(wine.id) end
    end

    test "change_wine/1 returns a wine changeset" do
      wine = wine_fixture()
      assert %Ecto.Changeset{} = Wines.change_wine(wine)
    end
  end
end
