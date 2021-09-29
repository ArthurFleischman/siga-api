defmodule SigaWeb.ProfilePicControllerTest do
  use SigaWeb.ConnCase

  alias Siga.Assets
  alias Siga.Assets.ProfilePic

  @create_attrs %{
    filename: "some filename"
  }
  @update_attrs %{
    filename: "some updated filename"
  }
  @invalid_attrs %{filename: nil}

  def fixture(:profile_pic) do
    {:ok, profile_pic} = Assets.create_profile_pic(@create_attrs)
    profile_pic
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all profile_pic", %{conn: conn} do
      conn = get(conn, Routes.profile_pic_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create profile_pic" do
    test "renders profile_pic when data is valid", %{conn: conn} do
      conn = post(conn, Routes.profile_pic_path(conn, :create), profile_pic: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.profile_pic_path(conn, :show, id))

      assert %{
               "id" => id,
               "filename" => "some filename"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.profile_pic_path(conn, :create), profile_pic: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update profile_pic" do
    setup [:create_profile_pic]

    test "renders profile_pic when data is valid", %{conn: conn, profile_pic: %ProfilePic{id: id} = profile_pic} do
      conn = put(conn, Routes.profile_pic_path(conn, :update, profile_pic), profile_pic: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.profile_pic_path(conn, :show, id))

      assert %{
               "id" => id,
               "filename" => "some updated filename"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, profile_pic: profile_pic} do
      conn = put(conn, Routes.profile_pic_path(conn, :update, profile_pic), profile_pic: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete profile_pic" do
    setup [:create_profile_pic]

    test "deletes chosen profile_pic", %{conn: conn, profile_pic: profile_pic} do
      conn = delete(conn, Routes.profile_pic_path(conn, :delete, profile_pic))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.profile_pic_path(conn, :show, profile_pic))
      end
    end
  end

  defp create_profile_pic(_) do
    profile_pic = fixture(:profile_pic)
    %{profile_pic: profile_pic}
  end
end
