defmodule EasedBackend.Repo.Migrations.CreateTeacherStudentMatch do
  use Ecto.Migration

  def change do
    create table(:teacher_student_matches) do
      add :possibility, :integer
      add :student_id, references(:students, on_delete: :nothing)
      add :teacher_id, references(:teachers, on_delete: :nothing)

      timestamps()
    end
    create index(:teacher_student_matches, [:student_id])
    create index(:teacher_student_matches, [:teacher_id])

  end
end
