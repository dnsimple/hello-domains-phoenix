defmodule HelloDomains.PageController do
  use HelloDomains.Web, :controller

  plug HelloDomains.Plug.CurrentAccount

  def index(conn, _params) do
    account = conn.assigns[:current_account]

    case HelloDomains.Dnsimple.domains(account) do
      {:ok, domains} ->
        render conn, "index.html", dnsimple_domains: domains
      {:error, error} ->
        IO.inspect(error)
        raise "Failed to retreive account domains: #{inspect error}"
    end
  end
end
