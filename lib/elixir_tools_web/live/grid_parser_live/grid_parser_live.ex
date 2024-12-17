defmodule ElixirToolsWeb.GridParserLive do
  use ElixirToolsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    # # Let's assume a fixed cols_count for now
    # text = """
    # ............
    # ........0...
    # .....0......
    # .......0....
    # ....0.......
    # ......A.....
    # ............
    # ............
    # ........A...
    # .........A..
    # """

    # text_map = text |> parse_text_to_map()

    # rows = text |> String.split("\n", trim: true)
    # rows_count = rows |> Enum.count()
    # cols_count = rows |> Enum.at(0) |> String.length()
    # socket = assign(socket, :cols_count, cols_count)

    # socket = assign(socket, :rows_count, rows_count)
    # socket = assign(socket, input_text: "", text_map: text_map)
    socket =
      assign(socket, text_map: %{})
      |> assign(:cols_count, 0)
      |> assign(:rows_count, 0)

    {:ok, socket}
  end

  @impl true
  def handle_event("parse_text", %{"text" => text}, socket) do
    {text_map, rows_count, cols_count} = parse_text_to_map(text)

    socket = socket |> assign_result(text_map, rows_count, cols_count)
    {:noreply, socket}
  end

  defp parse_text_to_map(text) do
    rows = text |> String.trim() |> String.split("\n", trim: true)

    text_map =
      rows
      |> Enum.with_index(fn element, index -> {index, element} end)
      |> Enum.reduce(%{}, fn {row_index, line}, acc ->
        line
        |> String.graphemes()
        |> Enum.with_index(fn element, index -> {index, element} end)
        |> Enum.reduce(acc, fn {col_index, char}, inner_acc ->
          Map.put(inner_acc, {row_index, col_index}, char)
        end)
      end)

    rows_count = rows |> Enum.count()
    cols_count = rows |> Enum.at(0) |> String.length()

    {text_map, rows_count, cols_count}
  end

  defp assign_result(socket, text_map, rows_count, cols_count) do
    socket
    |> assign(:cols_count, cols_count)
    |> assign(:rows_count, rows_count)
    |> assign(:text_map, text_map)
  end
end
