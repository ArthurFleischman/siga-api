defmodule Siga.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :cpf, :string
    field :email, :string
    field :name, :string
    field :password, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :cpf, :email, :password, :role])
    |> validate_required([:name, :cpf, :email, :password, :role])
    |> unique_constraint(:cpf)
    |> unique_constraint(:email)
  end

  def hash_password(changeset) do
    changeset
    |> get_field(:password)
    |> Bcrypt.Base.hash_password(
      Bcrypt.gen_salt(Application.get_env(:bcrypt_elixir, :log_rounds), true)
    )
    |> (fn value -> %{password: value} end).()
    |> (fn map -> changeset(changeset, map) end).()
  end
end