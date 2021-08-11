defmodule SigaWeb.UserControllerTest do
  use SigaWeb.ConnCase

  alias Siga.Accounts
  alias Siga.Accounts.User

  @create_attrs %{
    birthdate: ~D[2010-04-17],
    cpf: "some cpf",
    email: "some email",
    freashman: ~D[2010-04-17],
    name: "some name",
    password: "some password",
    phone: "some phone",
    role: "some role"
  }
  @update_attrs %{
    birthdate: ~D[2011-05-18],
    cpf: "some updated cpf",
    email: "some updated email",
    freashman: ~D[2011-05-18],
    name: "some updated name",
    password: "some updated password",
    phone: "some updated phone",
    role: "some updated role"
  }
  @invalid_attrs %{birthdate: nil, cpf: nil, email: nil, freashman: nil, name: nil, password: nil, phone: nil, role: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "birthdate" => "2010-04-17",
               "cpf" => "some cpf",
               "email" => "some email",
               "freashman" => "2010-04-17",
               "name" => "some name",
               "password" => "some password",
               "phone" => "some phone",
               "role" => "some role"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "birthdate" => "2011-05-18",
               "cpf" => "some updated cpf",
               "email" => "some updated email",
               "freashman" => "2011-05-18",
               "name" => "some updated name",
               "password" => "some updated password",
               "phone" => "some updated phone",
               "role" => "some updated role"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
