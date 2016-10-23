defmodule EasedBackend.Auth do
  import Plug.Conn

  alias EasedBackend.Repo

  def init(opts), do: opts

  def call(conn, opts) do
    role = Keyword.fetch!(opts, :role)

    case find_user(conn, role) do
      {:ok, user} -> assign(conn, :current_user, user)
      _otherwise  -> auth_error!(conn)
    end
  end

  defp find_user(conn, role) do
    with auth_header = get_req_header(conn, "authorization"),
         {:ok, user_id} <- parse_token(conn, auth_header),
    do:  find_user_by_user_id(user_id, role)
  end

  defp parse_token(conn, auth_header) do
    case Phoenix.Token.verify(conn, "user", auth_header) do
      {:error, _} -> :error
      {:ok, user_id} -> {:ok, user_id}
    end
  end

  defp find_user_by_user_id(user_id, "student") do
    case Repo.get(EasedBackend.Student, user_id) do
      nil  -> :error
      user -> {:ok, user}
    end
  end

  defp find_user_by_user_id(user_id, "teacher") do
    case Repo.get(EasedBackend.Teacher, user_id) do
      nil  -> :error
      user -> {:ok, user}
    end
  end

  defp auth_error!(conn) do
    conn |> put_status(:unauthorized) |> halt()
  end

end
