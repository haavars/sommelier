defmodule Sommelier.Index do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_opts \\ []) do
    index = ExFaiss.Index.new(384, "IDMap,Flat")
    {:ok, index}
  end

  def add(id, embedding) do
    GenServer.cast(__MODULE__, {:add, id, embedding})
  end

  def handle_cast({:add, id, embedding}, index) do
    index = ExFaiss.Index.add_with_ids(index, embedding, id)
    {:noreply, index}
  end

  def search(embedding, k) do
    GenServer.call(__MODULE__, {:search, embedding, k})
  end

  def handle_call({:search, embedding, k}, _from, index) do
    results = ExFaiss.Index.search(index, embedding, k)
    {:reply, results, index}
  end
end
