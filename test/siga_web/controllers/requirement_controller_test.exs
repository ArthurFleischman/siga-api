defmodule SigaWeb.RequirementControllerTest do
  use SigaWeb.ConnCase

  alias Siga.Subjects
  alias Siga.Subjects.Requirement

  @create_attrs %{
    type: "some type"
  }
  @update_attrs %{
    type: "some updated type"
  }
  @invalid_attrs %{type: nil}

  def fixture(:requirement) do
    {:ok, requirement} = Subjects.create_requirement(@create_attrs)
    requirement
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all requirement", %{conn: conn} do
      conn = get(conn, Routes.requirement_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create requirement" do
    test "renders requirement when data is valid", %{conn: conn} do
      conn = post(conn, Routes.requirement_path(conn, :create), requirement: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.requirement_path(conn, :show, id))

      assert %{
               "id" => id,
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.requirement_path(conn, :create), requirement: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update requirement" do
    setup [:create_requirement]

    test "renders requirement when data is valid", %{conn: conn, requirement: %Requirement{id: id} = requirement} do
      conn = put(conn, Routes.requirement_path(conn, :update, requirement), requirement: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.requirement_path(conn, :show, id))

      assert %{
               "id" => id,
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, requirement: requirement} do
      conn = put(conn, Routes.requirement_path(conn, :update, requirement), requirement: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete requirement" do
    setup [:create_requirement]

    test "deletes chosen requirement", %{conn: conn, requirement: requirement} do
      conn = delete(conn, Routes.requirement_path(conn, :delete, requirement))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.requirement_path(conn, :show, requirement))
      end
    end
  end

  defp create_requirement(_) do
    requirement = fixture(:requirement)
    %{requirement: requirement}
  end
end
