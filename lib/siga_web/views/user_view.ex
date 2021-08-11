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
    %{id: user.id,
      name: user.name,
      password: user.password,
      cpf: user.cpf,
      phone: user.phone,
      birthdate: user.birthdate,
      role: user.role,
      email: user.email,
      freashman: user.freashman}
  end
end
