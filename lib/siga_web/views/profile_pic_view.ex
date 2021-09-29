defmodule SigaWeb.ProfilePicView do
  use SigaWeb, :view
  alias SigaWeb.ProfilePicView

  def render("index.json", %{profile_pic: profile_pic}) do
    %{data: render_many(profile_pic, ProfilePicView, "profile_pic.json")}
  end

  def render("show.json", %{profile_pic: profile_pic}) do
    %{data: render_one(profile_pic, ProfilePicView, "profile_pic.json")}
  end

  def render("profile_pic.json", %{profile_pic: profile_pic}) do
    %{id: profile_pic.id,
      filename: profile_pic.filename}
  end
end
