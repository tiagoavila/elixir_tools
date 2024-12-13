defmodule ElixirToolsWeb.GridParserLiveTest do
  use ElixirToolsWeb.ConnCase

  import Phoenix.LiveViewTest
  import ElixirTools.ToolsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_grid_parser(_) do
    grid_parser = grid_parser_fixture()
    %{grid_parser: grid_parser}
  end

  describe "Index" do
    setup [:create_grid_parser]

    test "lists all grid-parser", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/grid-parser")

      assert html =~ "Listing Grid-parser"
    end

    test "saves new grid_parser", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/grid-parser")

      assert index_live |> element("a", "New Grid parser") |> render_click() =~
               "New Grid parser"

      assert_patch(index_live, ~p"/grid-parser/new")

      assert index_live
             |> form("#grid_parser-form", grid_parser: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#grid_parser-form", grid_parser: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/grid-parser")

      html = render(index_live)
      assert html =~ "Grid parser created successfully"
    end

    test "updates grid_parser in listing", %{conn: conn, grid_parser: grid_parser} do
      {:ok, index_live, _html} = live(conn, ~p"/grid-parser")

      assert index_live |> element("#grid-parser-#{grid_parser.id} a", "Edit") |> render_click() =~
               "Edit Grid parser"

      assert_patch(index_live, ~p"/grid-parser/#{grid_parser}/edit")

      assert index_live
             |> form("#grid_parser-form", grid_parser: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#grid_parser-form", grid_parser: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/grid-parser")

      html = render(index_live)
      assert html =~ "Grid parser updated successfully"
    end

    test "deletes grid_parser in listing", %{conn: conn, grid_parser: grid_parser} do
      {:ok, index_live, _html} = live(conn, ~p"/grid-parser")

      assert index_live |> element("#grid-parser-#{grid_parser.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#grid-parser-#{grid_parser.id}")
    end
  end

  describe "Show" do
    setup [:create_grid_parser]

    test "displays grid_parser", %{conn: conn, grid_parser: grid_parser} do
      {:ok, _show_live, html} = live(conn, ~p"/grid-parser/#{grid_parser}")

      assert html =~ "Show Grid parser"
    end

    test "updates grid_parser within modal", %{conn: conn, grid_parser: grid_parser} do
      {:ok, show_live, _html} = live(conn, ~p"/grid-parser/#{grid_parser}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Grid parser"

      assert_patch(show_live, ~p"/grid-parser/#{grid_parser}/show/edit")

      assert show_live
             |> form("#grid_parser-form", grid_parser: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#grid_parser-form", grid_parser: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/grid-parser/#{grid_parser}")

      html = render(show_live)
      assert html =~ "Grid parser updated successfully"
    end
  end
end
