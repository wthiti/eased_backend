defmodule EasedBackend.TeacherStudentMatchTest do
  use EasedBackend.ModelCase

  alias EasedBackend.TeacherStudentMatch

  @valid_attrs %{possibility: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TeacherStudentMatch.changeset(%TeacherStudentMatch{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TeacherStudentMatch.changeset(%TeacherStudentMatch{}, @invalid_attrs)
    refute changeset.valid?
  end
end
