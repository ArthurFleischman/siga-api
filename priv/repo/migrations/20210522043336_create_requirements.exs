defmodule Siga.Repo.Migrations.CreateRequirements do
  use Ecto.Migration

  def change do
    create table(:requirements, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string
      add :subject, references(:subjects, on_delete: :nothing, type: :binary_id)
      add :requirement, references(:subjects, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:requirements, [:subject])
    create index(:requirements, [:requirement])
  end
end
