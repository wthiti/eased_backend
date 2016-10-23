defmodule EasedBackend.Repo.Migrations.CreateRequest do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :course, :string
      add :duration, :string
      add :time, :string
      add :place, :string
      add :status, :string
      add :student_id, references(:students, on_delete: :nothing)

      timestamps()
    end
    create index(:requests, [:student_id])

  end
end
