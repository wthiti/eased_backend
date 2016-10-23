defmodule EasedBackend.Repo.Migrations.CreateRequestTeacher do
  use Ecto.Migration

  def change do
    create table(:request_teachers) do
      add :possibility, :integer
      add :request_id, references(:requests, on_delete: :nothing)
      add :teacher_id, references(:teachers, on_delete: :nothing)

      timestamps()
    end
    create index(:request_teachers, [:request_id])
    create index(:request_teachers, [:teacher_id])

  end
end
