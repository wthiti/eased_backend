defmodule EasedBackend.RequestsTest do
  use EasedBackend.ModelCase

  alias EasedBackend.Requests

  @valid_attrs %{course: "some content", duration: "some content", place: "some content", status: "some content", time: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Requests.changeset(%Requests{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Requests.changeset(%Requests{}, @invalid_attrs)
    refute changeset.valid?
  end
end
