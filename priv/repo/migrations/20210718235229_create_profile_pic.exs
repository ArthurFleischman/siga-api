defmodule Siga.Repo.Migrations.CreateProfilePic do
  use Ecto.Migration

  def change do
    create table(:profile_pic, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :filename, :string

      timestamps()
    end

  end
end
