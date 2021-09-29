defmodule Siga.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :password, :string
      add :cpf, :string
      add :phone, :string
      add :birthdate, :date
      add :role, :string
      add :email, :string
      add :freashman, :date
      add :id_profile_pic, references(:profile_pic, on_delete: :nothing, type: :binary_id)
      timestamps()
    end

    create unique_index(:users, [:cpf])
    create unique_index(:users, [:email])
    create unique_index(:users, [:phone])
  end
end
