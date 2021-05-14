defmodule SigaWeb.UserView do
  use SigaWeb, :view
  alias SigaWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      cpf: user.cpf,
      email: user.email,
      password: user.password,
      role: user.role
    }
  end

  def render("404.json", %{reason: reason}) do
    %{errors: %{details: reason}}
  end
end
