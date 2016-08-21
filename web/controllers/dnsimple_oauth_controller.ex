defmodule HelloDomains.DnsimpleOauthController do
  use HelloDomains.Web, :controller

  alias HelloDomains.Account

  def new(conn, _params) do
    client    = %Dnsimple.Client{}
    client_id = Application.fetch_env!(:hello_domains, :dnsimple_client_id)
    state = :crypto.strong_rand_bytes(8) |> Base.url_encode64 |> binary_part(0, 8)
    assign(conn, :dnsimple_oauth_state, state)
    conn = put_session(conn, :dnsimple_oauth_state, state)
    oauth_url = HelloDomains.Dnsimple.authorize_url(client, client_id, state: state)
    redirect(conn, external: oauth_url)
  end

  def create(conn, params) do
    # verify state
    if params["state"] != get_session(conn, :dnsimple_oauth_state) do
      raise "State does not match"
    end

    client = %Dnsimple.Client{}
    attributes = %{
      client_id: Application.fetch_env!(:hello_domains, :dnsimple_client_id),
      client_secret: Application.fetch_env!(:hello_domains, :dnsimple_client_secret),
      code: params["code"],
      state: params["state"]
    }
    case HelloDomains.Dnsimple.exchange_authorization_for_token(client, attributes) do
      {:ok, response} ->
        access_token = response.data.access_token
        client = %Dnsimple.Client{access_token: access_token}
        case HelloDomains.Dnsimple.whoami(client) do
          {:ok, %Dnsimple.Response{data: data}} ->
            account = Account.find_or_create!(Integer.to_string(data.account["id"]), %{
              "dnsimple_account_email" => data.account["email"],
              "dnsimple_access_token" => access_token
            })

            conn
            |> put_session(:account_id, account.id)
            |> render("welcome.html", account: account)
          {:error, error} ->
            IO.inspect(error)
            raise "Failed to retreive account details: #{inspect error}"
        end
      {:error, error} ->
        IO.inspect(error)
        raise "OAuth authentication failed: #{inspect error}"
    end
  end

end

