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

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(requirement, attrs) do
    requirement
    |> cast(attrs, [:type])
    |> validate_required([:type])
  end
end
