defmodule ElixirToolsWeb.GridParserLive do
  use ElixirToolsWeb, :live_view

  alias ElixirTools.Tools
  alias ElixirTools.Tools.GridParser

  @impl true
  def mount(_params, _session, socket) do
    # Let's assume a fixed cols_count for now
    text = """
    ............
    ........0...
    .....0......
    .......0....
    ....0.......
    ......A.....
    ............
    ............
    ........A...
    .........A..
    """

    text_map = text |> parse_text_to_map()

    rows = text |> String.split("\n", trim: true)
    rows_count = rows |> Enum.count()
    cols_count = rows |> Enum.at(0) |> String.length()
    socket = assign(socket, :cols_count, cols_count)

    socket = assign(socket, :rows_count, rows_count)
    socket = assign(socket, input_text: "", parsed_map: text_map)
    {:ok, socket}
  end

  @impl true
  def handle_event("parse_text", %{"text" => text}, socket) do
    parsed_map = parse_text_to_map(text)
    {:noreply, assign(socket, input_text: text, parsed_map: parsed_map)}
  end

  defp parse_text_to_map(text) do
    text
    |> String.split("\n", trim: true)
    |> Enum.with_index(fn element, index -> {index, element} end)
    |> Enum.reduce(%{}, fn {row_index, line}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index(fn element, index -> {index, element} end)
      |> Enum.reduce(acc, fn {col_index, char}, inner_acc ->
        Map.put(inner_acc, {row_index, col_index}, char)
      end)
    end)
  end

  # @impl true
  # def handle_event("delete", %{"id" => id}, socket) do
  #   grid_parser = Tools.get_grid_parser!(id)
  #   {:ok, _} = Tools.delete_grid_parser(grid_parser)

  #   {:noreply, stream_delete(socket, :grid-parser, grid_parser)}
  # end
end
