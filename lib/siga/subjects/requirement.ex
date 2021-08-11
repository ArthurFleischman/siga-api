defmodule Siga.Subjects.Requirement do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "requirement" do
    field :type, :string
    field :subject, :binary_id
    field :requirement, :binary_id

    timestamps()
  end

  @doc false
  def changeset(requirement, attrs) do
    requirement
    |> cast(attrs, [:type])
    |> validate_required([:type])
  end
end
