defmodule Siga.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Cpfcnpj

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :birthdate, :date, null: false
    field :cpf, :string, null: false
    field :email, :string, null: false
    field :freashman, :date, null: false
    field :name, :string, null: false
    field :password, :string, null: false
    field :phone, :string, null: false
    field :role, Ecto.Enum, values: [:student, :professor, :admin], null: false
    field :pic_path, :string
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :password, :cpf, :phone, :birthdate, :role, :email, :freashman])
    |> validate_required([:name, :password, :cpf, :phone, :birthdate, :role, :email, :freashman])
    |> unique_constraint(:cpf)
    |> unique_constraint(:email)
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
        dd_error(changeset, :cpf, "cpf is invalid")
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

  defp set_profile_pic_name(changeset) do
    changeset
    |> get_field(:cpf)
    |> (fn cpf -> %{pic_path: Application.get_env(:siga, :upload_folder) <> "/" <> cpf} end).()
    |> (fn path -> cast(changeset, path, [:pic_path]) end).()
  end

  def insert_pic(changeset, profile_pic) when is_binary(profile_pic) do
    with pic <- Base.decode64!(profile_pic) do
      changeset
      |> set_profile_pic_name()
      |> get_field(:pic_path)
      |> File.write!(pic)
    end

    changeset
  end
end
