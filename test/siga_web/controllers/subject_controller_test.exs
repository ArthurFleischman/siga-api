defmodule SigaWeb.SubjectControllerTest do
  use SigaWeb.ConnCase

  alias Siga.Subjects
  alias Siga.Subjects.Subject

  @create_attrs %{
    hours: 42,
    name: "some name"
  }
  @update_attrs %{
    hours: 43,
    name: "some updated name"
  }
  @invalid_attrs %{hours: nil, name: nil}

  def fixture(:subject) do
    {:ok, subject} = Subjects.create_subject(@create_attrs)
    subject
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all subjects", %{conn: conn} do
      conn = get(conn, Routes.subject_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create subject" do
    test "renders subject when data is valid", %{conn: conn} do
      conn = post(conn, Routes.subject_path(conn, :create), subject: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.subject_path(conn, :show, id))

      assert %{
               "id" => id,
               "hours" => 42,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.subject_path(conn, :create), subject: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update subject" do
    setup [:create_subject]

    test "renders subject when data is valid", %{conn: conn, subject: %Subject{id: id} = subject} do
      conn = put(conn, Routes.subject_path(conn, :update, subject), subject: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.subject_path(conn, :show, id))

      assert %{
               "id" => id,
               "hours" => 43,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, subject: subject} do
      conn = put(conn, Routes.subject_path(conn, :update, subject), subject: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete subject" do
    setup [:create_subject]

    test "deletes chosen subject", %{conn: conn, subject: subject} do
      conn = delete(conn, Routes.subject_path(conn, :delete, subject))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.subject_path(conn, :show, subject))
      end
    end
  end

  defp create_subject(_) do
    subject = fixture(:subject)
    %{subject: subject}
  end
end
