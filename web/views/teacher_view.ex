defmodule EasedBackend.TeacherView do
  use EasedBackend.Web, :view

  def render("index.json", %{teachers: teachers}) do
    %{data: render_many(teachers, EasedBackend.TeacherView, "teacher.json")}
  end

  def render("show.json", %{teacher: teacher}) do
    %{data: render_one(teacher, EasedBackend.TeacherView, "teacher.json")}
  end

  def render("teacher.json", %{teacher: teacher}) do
    %{id: teacher.id,
      name: teacher.name,
      phone: teacher.phone,
      email: teacher.email,
      facebook_url: teacher.facebook_url}
  end
end
