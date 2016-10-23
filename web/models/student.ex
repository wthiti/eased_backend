defmodule EasedBackend.Student do
  use EasedBackend.Web, :model

  schema "students" do
    field :name, :string
    field :phone, :string
    field :email, :string
    field :facebook_url, :string
    has_many :request, EasedBackend.Request
    has_many :teacher_student_match, EasedBackend.TeacherStudentMatch

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :phone, :email, :facebook_url])
    |> validate_required([:name, :phone, :email, :facebook_url])
  end
end
