defmodule EmbedWineDocuments do
  def format_document(document) do
    "Name: #{document["name"]}\n" <>
      "Varietal: #{document["varietal"]}\n" <>
      "Location: #{document["location"]}\n" <>
      "Alcohol Volume: #{document["alcohol_volume"]}\n" <>
      "Alcohol Percent: #{document["alcohol_percent"]}\n" <>
      "Price: #{document["price"]}\n" <>
      "Winemaker Notes: #{document["notes"]}\n" <>
      "Reviews:\n#{format_reviews(document["reviews"])}"
  end

  defp format_reviews(reviews) do
    reviews
    |> Enum.map(fn review ->
      "Reviewer: #{review["author"]}\n" <>
        "Review: #{review["review"]}\n" <>
        "Rating: #{review["rating"]}"
    end)
    |> Enum.join("\n")
  end
end

"priv/wine_documents.jsonl"
|> File.stream!()
|> Stream.map(&Jason.decode!/1)
|> Stream.map(fn document ->
  desc = EmbedWineDocuments.format_document(document)
  embedding = Sommelier.Model.predict(desc)
  {document["name"], document["url"], embedding}
end)
|> Enum.each(fn {name, url, embedding} ->
  Sommelier.Wines.create_wine(%{
    "name" => name,
    "url" => url,
    "embedding" => Nx.to_binary(embedding)
  })
end)
