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

      timestamps()
    end

    create unique_index(:users, [:cpf])
    create unique_index(:users, [:email])
  end
end
