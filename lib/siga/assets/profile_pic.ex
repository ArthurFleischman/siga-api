defmodule Siga.Assets.ProfilePic do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "profile_pic" do
    field :filename, :string

    timestamps()
  end

  @doc false
  def changeset(profile_pic, attrs) do
    profile_pic
    |> cast(attrs, [:filename])
    |> validate_required([:filename])
  end
end
