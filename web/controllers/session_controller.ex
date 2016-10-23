defmodule EasedBackend.SessionController do
  use EasedBackend.Web, :controller

  def create(conn, %{"user_id" => user_id}) do
    render conn, "session.json", %{token: Phoenix.Token.sign(conn, "user", user_id)}
  end
end
