defmodule EasedBackend.TeacherTest do
  use EasedBackend.ModelCase

  alias EasedBackend.Teacher

  @valid_attrs %{email: "some content", facebook_url: "some content", name: "some content", phone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Teacher.changeset(%Teacher{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Teacher.changeset(%Teacher{}, @invalid_attrs)
    refute changeset.valid?
  end
end
