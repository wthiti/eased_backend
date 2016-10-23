defmodule EasedBackend.RequestTeacherControllerTest do
  use EasedBackend.ConnCase

  alias EasedBackend.RequestTeacher
  @valid_attrs %{possibility: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, request_teacher_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    request_teacher = Repo.insert! %RequestTeacher{}
    conn = get conn, request_teacher_path(conn, :show, request_teacher)
    assert json_response(conn, 200)["data"] == %{"id" => request_teacher.id,
      "request_id" => request_teacher.request_id,
      "teacher_id" => request_teacher.teacher_id,
      "possibility" => request_teacher.possibility}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, request_teacher_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, request_teacher_path(conn, :create), request_teacher: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(RequestTeacher, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, request_teacher_path(conn, :create), request_teacher: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    request_teacher = Repo.insert! %RequestTeacher{}
    conn = put conn, request_teacher_path(conn, :update, request_teacher), request_teacher: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(RequestTeacher, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    request_teacher = Repo.insert! %RequestTeacher{}
    conn = put conn, request_teacher_path(conn, :update, request_teacher), request_teacher: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    request_teacher = Repo.insert! %RequestTeacher{}
    conn = delete conn, request_teacher_path(conn, :delete, request_teacher)
    assert response(conn, 204)
    refute Repo.get(RequestTeacher, request_teacher.id)
  end
end
