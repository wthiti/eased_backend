defmodule EasedBackend.RequestsControllerTest do
  use EasedBackend.ConnCase

  alias EasedBackend.Requests
  @valid_attrs %{course: "some content", duration: "some content", place: "some content", status: "some content", time: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, requests_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    requests = Repo.insert! %Requests{}
    conn = get conn, requests_path(conn, :show, requests)
    assert json_response(conn, 200)["data"] == %{"id" => requests.id,
      "student_id" => requests.student_id,
      "course" => requests.course,
      "duration" => requests.duration,
      "time" => requests.time,
      "place" => requests.place,
      "status" => requests.status}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, requests_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, requests_path(conn, :create), requests: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Requests, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, requests_path(conn, :create), requests: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    requests = Repo.insert! %Requests{}
    conn = put conn, requests_path(conn, :update, requests), requests: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Requests, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    requests = Repo.insert! %Requests{}
    conn = put conn, requests_path(conn, :update, requests), requests: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    requests = Repo.insert! %Requests{}
    conn = delete conn, requests_path(conn, :delete, requests)
    assert response(conn, 204)
    refute Repo.get(Requests, requests.id)
  end
end
