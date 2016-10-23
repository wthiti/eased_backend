defmodule EasedBackend.RequestController do
  use EasedBackend.Web, :controller

  alias EasedBackend.Request
  alias EasedBackend.RequestTeacher

  def student_index(conn, _params) do
    student = conn.assigns.current_user

    q = from r in Request,
      where: r.student_id == ^student.id,
      select: r
    requests = Repo.all(q)

    render(conn, "index.json", requests: requests)
  end

  def student_new(conn, _params) do
    course = ["TOEFL", "TOEIC"]
    duration = [5,10,15]

    render(conn, "new.json", request: %Request{course: course, duration: duration})
  end

  def student_create(conn, %{"request" => request_params}) do
    student = conn.assigns.current_user
    request = %Request{
      student_id: student.id,
      status: "Created"
    }

    changeset = Request.changeset(request, request_params)
    case Repo.insert(changeset) do
      {:ok, request} ->
        conn
        |> put_status(:created)
        |> render("id.json", request: request)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EasedBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def student_show(conn, %{"id" => id}) do
    request = Repo.get!(Request, id)
      |> Repo.preload(:request_teachers, request_teachers: [:teacher] )

    render(conn, "student_show.json", %{request: request})
  end

  def student_update(conn, %{"id" => id}) do
    request = Repo.get!(Request, id)
    changeset = Request.changeset_selected(request)

    case Repo.update(changeset) do
      {:ok, request} ->
        render(conn, "id.json", request: request)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EasedBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def teacher_index(conn, _params) do
    teacher = conn.assigns.current_user

    q = from r in Request,
      where: r.status == "Created",
      select: r
    requests =
      Repo.all(q)
      |> Repo.preload(:student)
      |> Enum.map( fn request ->
        Map.put(request, :student_possibility, get_student_teacher_possibility(request.student_id, teacher.id) )
      end)

    render(conn, "index.json", requests: requests)
  end

  def teacher_show(conn, %{"id" => id}) do
    teacher = conn.assigns.current_user

    request = Repo.get!(Request, id)
      |> Repo.preload(:student)

    request = Map.put(request, :student_possibility, get_student_teacher_possibility(request.student_id, teacher.id))

    render(conn, "teacher_show.json", %{request: request})
  end

  def teacher_update(conn, %{"id" => id}) do
    teacher = conn.assigns.current_user

    request = Repo.get!(Request, id)
    possibility = get_student_teacher_possibility(request.student_id, teacher.id)

    request_teacher = %RequestTeacher{
      request_id: request.id,
      teacher_id: teacher.id,
      possibility: possibility
    }

    changeset = RequestTeacher.changeset(request_teacher)

    case Repo.insert(changeset) do
      {:ok, _request_teacher} ->
        conn
        |> put_status(:created)
        |> render("id.json", request: request)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EasedBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp get_student_teacher_possibility(student_id, teacher_id) do
    teacher_student_match = Repo.get_by(EasedBackend.TeacherStudentMatch, student_id: student_id, teacher_id: teacher_id)
    if teacher_student_match, do: teacher_student_match.possibility, else: 0
  end

  def delete(conn, %{"id" => id}) do
    request = Repo.get!(Request, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(request)

    send_resp(conn, :no_content, "")
  end
end
