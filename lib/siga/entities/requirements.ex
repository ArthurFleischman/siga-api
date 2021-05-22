defmodule Siga.Entities.Requirements do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "requirements" do
    field :type, :string
    field :subject, :binary_id
    field :requirement, :binary_id

    timestamps()
  end

  @doc false
  def changeset(requirements, attrs) do
    requirements
    |> cast(attrs, [:type, :subject, :requirement])
    |> validate_required([:type, :subject, :requirement])
    |> validate_inclusion(:type, ["co", "pre"], message: "invalid requirement type")
  end
end
