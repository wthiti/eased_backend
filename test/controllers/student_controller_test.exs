defmodule EasedBackend.StudentControllerTest do
  use EasedBackend.ConnCase

  alias EasedBackend.Student
  @valid_attrs %{email: "some content", facebook_url: "some content", name: "some content", phone: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, student_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    student = Repo.insert! %Student{}
    conn = get conn, student_path(conn, :show, student)
    assert json_response(conn, 200)["data"] == %{"id" => student.id,
      "name" => student.name,
      "phone" => student.phone,
      "email" => student.email,
      "facebook_url" => student.facebook_url}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, student_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, student_path(conn, :create), student: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Student, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, student_path(conn, :create), student: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    student = Repo.insert! %Student{}
    conn = put conn, student_path(conn, :update, student), student: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Student, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    student = Repo.insert! %Student{}
    conn = put conn, student_path(conn, :update, student), student: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    student = Repo.insert! %Student{}
    conn = delete conn, student_path(conn, :delete, student)
    assert response(conn, 204)
    refute Repo.get(Student, student.id)
  end
end
