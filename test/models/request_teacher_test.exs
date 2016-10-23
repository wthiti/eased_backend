defmodule EasedBackend.RequestTeacherTest do
  use EasedBackend.ModelCase

  alias EasedBackend.RequestTeacher

  @valid_attrs %{possibility: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = RequestTeacher.changeset(%RequestTeacher{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = RequestTeacher.changeset(%RequestTeacher{}, @invalid_attrs)
    refute changeset.valid?
  end
end
