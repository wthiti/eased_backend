defmodule EasedBackend.Request do
  use EasedBackend.Web, :model

  schema "requests" do
    field :course, :string
    field :duration, :string
    field :time, :string
    field :place, :string
    field :status, :string
    field :student_possibility, :integer, virtual: true
    belongs_to :student, EasedBackend.Student
    has_many :request_teachers, EasedBackend.RequestTeacher

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:course, :duration, :time, :place])
    |> validate_required([:course, :duration, :time, :place])
  end

  def changeset_selected(struct) do
    struct
    |> change
    |> put_change(:status, "Selected")
  end
end
