defmodule SommelierWeb.SearchLive.Index do
  use SommelierWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :results, [])}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <form name="wines-search" id="wines-search" phx-submit="search_for_wines">
        <label for="search" class="block text-sm font-medium text-gray-700">Quick search</label>
        <div class="relative mt-1 flex items-center">
          <input
            type="text"
            name="query"
            id="query"
            class="block w-full rounded-md border-gray-300 pr-12 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
          />
          <div class="absolute inset-y-0 right-0 flex py-1.5 pr-1.5">
            <kbd class="inline-flex items-center rounded border border-gray-200 px-2 font-sans text-sm font-medium text-gray-400">
              ⌘K
            </kbd>
          </div>
        </div>
      </form>
      <ul role="list" class="divide-y divide-gray-200">
        <li :for={result <- @results}>
          <p class="text-sm font-medium text-gray-900">
            <a href={result.url}><%= result.name %></a>
          </p>
        </li>
      </ul>
    </div>
    """
  end

  @impl true
  def handle_params(%{"q" => query}, _uri, socket) do
    results = Sommelier.Wines.search_wine(query)
    {:noreply, assign(socket, :results, results)}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_event("search_for_wines", %{"query" => query}, socket) do
    {:noreply, push_patch(socket, to: ~p"/search?q=#{query}")}
  end
end
