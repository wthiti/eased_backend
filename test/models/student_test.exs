defmodule EasedBackend.StudentTest do
  use EasedBackend.ModelCase

  alias EasedBackend.Student

  @valid_attrs %{email: "some content", facebook_url: "some content", name: "some content", phone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Student.changeset(%Student{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Student.changeset(%Student{}, @invalid_attrs)
    refute changeset.valid?
  end
end
