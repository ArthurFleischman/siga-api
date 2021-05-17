defmodule Siga.Accounts.User do
  use Ecto.Schema
  import Cpfcnpj
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
    |> validate_inclusion(:role, ["student", "professor"], message: "invalid role")
    |> validate_length(:cpf, is: 11)
    |> cpf_validation()
    |> unique_constraint(:cpf)
    |> unique_constraint(:email)
  end

  def cpf_validation(changeset) do
    changeset
    |> get_field(:cpf)
    |> (fn cpf -> valid?({:cpf, cpf}) end).()
    |> case do
      true ->
        changeset

      false ->
        add_error(changeset, :cpf, "cpf is invalid")
    end
  end

  def hash_password(changeset) do
    changeset
    |> get_field(:password)
    |> Bcrypt.Base.hash_password(
      Bcrypt.gen_salt(Application.get_env(:bcrypt_elixir, :log_rounds), true)
    )
    |> (fn value -> %{password: value} end).()
    |> (fn map -> cast(changeset, map, [:password]) end).()
  end

  def authenticate(user, password) do
    user
    |> (fn map -> Map.get(map, :password) end).()
    |> (fn hash_pass -> Bcrypt.verify_pass(password, hash_pass) end).()
    |> case do
      true ->
        {:ok, user}

      false ->
        {:not_found, "user not found"}
    end
  end

  def gen_jwt() do
  end
end
