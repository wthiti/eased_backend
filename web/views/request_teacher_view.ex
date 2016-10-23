defmodule EasedBackend.RequestTeacherView do
  use EasedBackend.Web, :view

  def render("request_teacher.json", %{request_teacher: request_teacher}) do
    %{
      teacher: render_one(request_teacher.teacher, EasedBackend.TeacherView, "teacher.json"),
      possibility: request_teacher.possibility
    }
  end
end
