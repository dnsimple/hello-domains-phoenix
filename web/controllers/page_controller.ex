defmodule HelloDomains.PageController do
  use HelloDomains.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
