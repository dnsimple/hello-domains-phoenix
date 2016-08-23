defmodule HelloDomains.PageControllerTest do
  use HelloDomains.ConnCase

  alias HelloDomains.Account

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert redirected_to(conn) == dnsimple_oauth_path(conn, :new)
  end

  test "account exists GET /", %{conn: conn} do
    account = Account.create!(%Account{dnsimple_account_id: "1"})
    conn = assign(conn, :current_account, account)
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Hello, DNSimple Domains!"
  end
end
