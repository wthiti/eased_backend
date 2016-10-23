defmodule EasedBackend.PageController do
  use EasedBackend.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
