defmodule SigaWeb.UserAuthView do
  use SigaWeb, :view
  alias SigaWeb.UserAuthView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserAuthView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserAuthView, "user.json")}
  end

  def render("404.json", %{reason: reason}) do
    %{errors: %{details: reason}}
  end

  def render("user.json", %{user: user, token: token}) do
    %{
      id: user.id,
      name: user.name,
      cpf: user.cpf,
      email: user.email,
      password: user.password,
      role: user.role,
      token: token
    }
  end
end
