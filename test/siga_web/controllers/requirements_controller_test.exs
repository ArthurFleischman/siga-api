defmodule SigaWeb.RequirementsControllerTest do
  use SigaWeb.ConnCase

  alias Siga.Entities
  alias Siga.Entities.Requirements

  @create_attrs %{
    type: "some type"
  }
  @update_attrs %{
    type: "some updated type"
  }
  @invalid_attrs %{type: nil}

  def fixture(:requirements) do
    {:ok, requirements} = Entities.create_requirements(@create_attrs)
    requirements
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all requirements", %{conn: conn} do
      conn = get(conn, Routes.requirements_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create requirements" do
    test "renders requirements when data is valid", %{conn: conn} do
      conn = post(conn, Routes.requirements_path(conn, :create), requirements: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.requirements_path(conn, :show, id))

      assert %{
               "id" => id,
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.requirements_path(conn, :create), requirements: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update requirements" do
    setup [:create_requirements]

    test "renders requirements when data is valid", %{conn: conn, requirements: %Requirements{id: id} = requirements} do
      conn = put(conn, Routes.requirements_path(conn, :update, requirements), requirements: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.requirements_path(conn, :show, id))

      assert %{
               "id" => id,
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, requirements: requirements} do
      conn = put(conn, Routes.requirements_path(conn, :update, requirements), requirements: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete requirements" do
    setup [:create_requirements]

    test "deletes chosen requirements", %{conn: conn, requirements: requirements} do
      conn = delete(conn, Routes.requirements_path(conn, :delete, requirements))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.requirements_path(conn, :show, requirements))
      end
    end
  end

  defp create_requirements(_) do
    requirements = fixture(:requirements)
    %{requirements: requirements}
  end
end
