defmodule HelloDomains.Dnsimple do

  @base_url Application.fetch_env!(:hello_domains, :dnsimple_client_base_url)
  @client_id Application.fetch_env!(:hello_domains, :dnsimple_client_id)
  @client_secret Application.fetch_env!(:hello_domains, :dnsimple_client_secret)

  # OAuth

  def authorize_url(client, options) do
    Dnsimple.Oauth.authorize_url(client, @client_id, state: options[:state])
  end

  def exchange_authorization_for_token(client, attributes) do
    attributes = Map.merge(attributes, %{client_id: @client_id, client_secret: @client_secret})
    oauth_service.exchange_authorization_for_token(client, attributes)
  end

  # Identity

  def whoami(client) do
    identity_service.whoami(client)
  end

  # Domains

  def domains(account) do
    domain_service.all_domains(client(account), account.dnsimple_account_id)
  end

  # Client for account

  def client(account) do
    %Dnsimple.Client{access_token: account.dnsimple_access_token}
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
end
