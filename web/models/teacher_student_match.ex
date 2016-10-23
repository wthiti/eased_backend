defmodule EasedBackend.TeacherStudentMatch do
  use EasedBackend.Web, :model

  schema "teacher_student_matches" do
    field :possibility, :integer
    belongs_to :student, EasedBackend.Student
    belongs_to :teacher, EasedBackend.Teacher

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:possibility])
    |> validate_required([:possibility])
  end
end
