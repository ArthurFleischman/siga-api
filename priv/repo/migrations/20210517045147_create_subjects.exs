defmodule Siga.Repo.Migrations.CreateSubjects do
  use Ecto.Migration

  def change do
    create table(:subjects, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :professor, :string
      add :hours, :integer
      add :pre_requirements, references(:subjects, on_delete: :nothing, type: :binary_id)
      add :co_requirements, references(:subjects, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:subjects, [:name])
    create index(:subjects, [:pre_requirements])
    create index(:subjects, [:co_requirements])
  end
end
