defmodule EasedBackend.RequestTeacher do
  use EasedBackend.Web, :model

  schema "request_teachers" do
    field :possibility, :integer
    field :enrolled, :boolean
    belongs_to :request, EasedBackend.Request
    belongs_to :teacher, EasedBackend.Teacher

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> change
  end
end
