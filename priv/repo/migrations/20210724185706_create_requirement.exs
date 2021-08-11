defmodule Siga.Repo.Migrations.CreateRequirement do
  use Ecto.Migration

  def change do
    create table(:requirement, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string
      add :subject, references(:subjects, on_delete: :nothing, type: :binary_id)
      add :requirement, references(:subjects, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:requirement, [:subject])
    create index(:requirement, [:requirement])
  end
end
