defmodule EasedBackend.TeacherStudentMatchControllerTest do
  use EasedBackend.ConnCase

  alias EasedBackend.TeacherStudentMatch
  @valid_attrs %{possibility: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, teacher_student_match_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    teacher_student_match = Repo.insert! %TeacherStudentMatch{}
    conn = get conn, teacher_student_match_path(conn, :show, teacher_student_match)
    assert json_response(conn, 200)["data"] == %{"id" => teacher_student_match.id,
      "student_id" => teacher_student_match.student_id,
      "teacher_id" => teacher_student_match.teacher_id,
      "possibility" => teacher_student_match.possibility}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, teacher_student_match_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, teacher_student_match_path(conn, :create), teacher_student_match: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(TeacherStudentMatch, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, teacher_student_match_path(conn, :create), teacher_student_match: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    teacher_student_match = Repo.insert! %TeacherStudentMatch{}
    conn = put conn, teacher_student_match_path(conn, :update, teacher_student_match), teacher_student_match: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(TeacherStudentMatch, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    teacher_student_match = Repo.insert! %TeacherStudentMatch{}
    conn = put conn, teacher_student_match_path(conn, :update, teacher_student_match), teacher_student_match: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    teacher_student_match = Repo.insert! %TeacherStudentMatch{}
    conn = delete conn, teacher_student_match_path(conn, :delete, teacher_student_match)
    assert response(conn, 204)
    refute Repo.get(TeacherStudentMatch, teacher_student_match.id)
  end
end
