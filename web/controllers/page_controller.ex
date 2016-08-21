defmodule HelloDomains.PageController do
  use HelloDomains.Web, :controller

  plug HelloDomains.Plug.CurrentAccount

  def index(conn, _params) do
    account = conn.assigns[:current_account]
    render conn, "index.html", dnsimple_domains: HelloDomains.Dnsimple.domains(account)
  end
end
