defmodule Siga.Entities.Subject do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "subjects" do
    field :hours, :integer
    field :name, :string
    field :professor, :binary_id

    timestamps()
  end

  @doc false
  def changeset(subject, attrs) do
    subject
    |> cast(attrs, [:name, :hours])
    |> validate_required([:name, :hours])
    |> unique_constraint(:name)
  end
end
