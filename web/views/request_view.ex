defmodule EasedBackend.RequestView do
  use EasedBackend.Web, :view

  def render("index.json", %{requests: requests}) do
    %{data: render_many(requests, EasedBackend.RequestView, "request.json")}
  end

  def render("show.json", %{request: request}) do
    %{data: render_one(request, EasedBackend.RequestView, "request.json")}
  end

  def render("student_show.json", %{request: request}) do
    %{data: render_one(request, EasedBackend.RequestView, "student_request.json")}
  end

  def render("teacher_show.json", %{request: request}) do
    %{data: render_one(request, EasedBackend.RequestView, "request.json")}
  end

  def render("student_request.json", %{request: request}) do
    %{
      id: request.id,
      student_id: request.student_id,
      course: request.course,
      duration: request.duration,
      time: request.time,
      place: request.place,
      status: request.status,
      request_teachers: render_many(request.request_teachers, EasedBackend.RequestTeacherView, "request_teacher.json")
    }
  end

  def render("id.json", %{request: request}) do
    %{id: request.id}
  end

  def render("new.json", %{request: request}) do
    %{
      course: request.course,
      duration: request.duration
    }
  end

  def render("request.json", %{request: request}) do
    student = if request.student, do: render_one(request.student, EasedBackend.Student, "student.json"), else: nil

    %{id: request.id,
      student: student,
      course: request.course,
      duration: request.duration,
      time: request.time,
      place: request.place,
      status: request.status,
      student_possibility: request.student_possibility}
  end
end
