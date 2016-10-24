defmodule EasedBackend.Repo.Migrations.AddEnrolledToRequestTeacher do
  use Ecto.Migration

  def change do
    alter table(:request_teachers) do
      add :enrolled, :boolean
    end
  end
end
