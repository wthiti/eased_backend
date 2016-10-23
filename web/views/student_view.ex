defmodule EasedBackend.StudentView do
  use EasedBackend.Web, :view

  def render("index.json", %{students: students}) do
    %{data: render_many(students, EasedBackend.StudentView, "student.json")}
  end

  def render("show.json", %{student: student}) do
    %{data: render_one(student, EasedBackend.StudentView, "student.json")}
  end

  def render("student.json", %{student: student}) do
    %{id: student.id,
      name: student.name,
      phone: student.phone,
      email: student.email,
      facebook_url: student.facebook_url}
  end
end
