defmodule SigaWeb.ProfilePicController do
  use SigaWeb, :controller

  alias Siga.Assets
  alias Siga.Assets.ProfilePic

  action_fallback SigaWeb.FallbackController

  def index(conn, _params) do
    profile_pic = Assets.list_profile_pic()
    render(conn, "index.json", profile_pic: profile_pic)
  end

  def create(conn, %{"profile_pic" => profile_pic_params}) do
    with {:ok, %ProfilePic{} = profile_pic} <- Assets.create_profile_pic(profile_pic_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.profile_pic_path(conn, :show, profile_pic))
      |> render("show.json", profile_pic: profile_pic)
    end
  end

  def show(conn, %{"id" => id}) do
    profile_pic = Assets.get_profile_pic!(id)
    render(conn, "show.json", profile_pic: profile_pic)
  end

  def update(conn, %{"id" => id, "profile_pic" => profile_pic_params}) do
    profile_pic = Assets.get_profile_pic!(id)

    with {:ok, %ProfilePic{} = profile_pic} <- Assets.update_profile_pic(profile_pic, profile_pic_params) do
      render(conn, "show.json", profile_pic: profile_pic)
    end
  end

  def delete(conn, %{"id" => id}) do
    profile_pic = Assets.get_profile_pic!(id)

    with {:ok, %ProfilePic{}} <- Assets.delete_profile_pic(profile_pic) do
      send_resp(conn, :no_content, "")
    end
  end
end
