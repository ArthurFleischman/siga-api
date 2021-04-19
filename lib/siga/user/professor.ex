defmodule Sysdev.User.Professor do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "professor" do
    field :email, :string
    field :name, :string
    field :password, :string
    field :professors, :string

    timestamps()
  end

  @doc false
  def changeset(professor, attrs) do
    professor
    |> cast(attrs, [:professors, :name, :email, :password])
    |> validate_required([:professors, :name, :email, :password])
  end
end
