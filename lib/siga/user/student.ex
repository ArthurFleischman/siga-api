defmodule Siga.User.Student do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "student" do
    field :email, :string
    field :name, :string
    field :password, :string
    field :students, :string

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:students, :name, :email, :password])
    |> validate_required([:students, :name, :email, :password])
  end
end
