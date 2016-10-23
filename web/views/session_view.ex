defmodule EasedBackend.SessionView do
  use EasedBackend.Web, :view

  def render("session.json", %{token: token}) do
    %{token: token}
  end
end
