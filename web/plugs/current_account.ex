defmodule HelloDomains.Plug.CurrentAccount do
  import Plug.Conn
  require Logger

  alias HelloDomains.Account

  def init(opts), do: opts

  def call(conn, _opts) do
    case current_account(conn) do
      nil ->
        conn
        |> Phoenix.Controller.redirect(to: HelloDomains.Router.Helpers.dnsimple_oauth_path(conn, :new))
        |> halt
      account ->
        assign(conn, :current_account, account)
    end
  end

  def current_account(conn) do
    case conn.assigns[:current_account] do
      nil -> fetch_account(conn)
      account -> account
    end
  end

  def account_connected?(conn), do: !!current_account(conn)

  def disconnect(conn), do: delete_session(conn, :account_id)

  defp fetch_account(conn) do
    case get_session(conn, :account_id) do
      nil -> nil
      account_id ->
        case Account.get(account_id) do
          nil -> nil
          account -> account
        end
    end
  end
end

