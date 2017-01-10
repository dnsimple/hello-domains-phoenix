defmodule HelloDomains.Dnsimple do

  # OAuth

  def authorize_url(options) do
    Dnsimple.Oauth.authorize_url(client, client_id, state: options[:state])
  end

  def exchange_authorization_for_token(attributes) do
    attributes = Map.merge(attributes, %{client_id: client_id, client_secret: client_secret})
    oauth_service.exchange_authorization_for_token(client, attributes)
  end

  # Identity

  def whoami(access_token) do
    identity_service.whoami(client(access_token))
  end

  # Domains

  def domains(account) do
    domain_service.all_domains(client(account), account.dnsimple_account_id)
  end

  # Client

  def client do
    %Dnsimple.Client{base_url: base_url}
  end
  def client(%HelloDomains.Account{dnsimple_access_token: access_token}) do
    client(access_token)
  end
  def client(access_token) do
    %Dnsimple.Client{base_url: base_url, access_token: access_token}
  end

  # Service modules

  defp oauth_service do
    Application.get_env(:hello_domains, :dnsimple_oauth_service, Dnsimple.Oauth)
  end

  defp identity_service do
    Application.get_env(:hello_domains, :dnsimple_identity_service, Dnsimple.Identity)
  end

  defp domain_service do
    Application.get_env(:hello_domains, :dnsimple_domains_service, Dnsimple.Domains)
  end

  # Configuration

  def base_url,      do: Application.fetch_env!(:hello_domains, :dnsimple_client_base_url)
  def client_id,     do: Application.fetch_env!(:hello_domains, :dnsimple_client_id)
  def client_secret, do: Application.fetch_env!(:hello_domains, :dnsimple_client_secret)

end
