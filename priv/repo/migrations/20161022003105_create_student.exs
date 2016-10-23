defmodule EasedBackend.Repo.Migrations.CreateStudent do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :name, :string
      add :phone, :string
      add :email, :string
      add :facebook_url, :string

      timestamps()
    end

  end
end
