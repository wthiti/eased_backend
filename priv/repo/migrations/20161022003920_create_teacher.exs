defmodule EasedBackend.Repo.Migrations.CreateTeacher do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add :name, :string
      add :phone, :string
      add :email, :string
      add :facebook_url, :string

      timestamps()
    end

  end
end
