defmodule HelloDomains.Dnsimple do
  # OAuth

  def authorize_url(client, client_id, options) do
    Dnsimple.OauthService.authorize_url(client, client_id, state: options[:state])
  end

  def exchange_authorization_for_token(client, attributes) do
    oauth_service.exchange_authorization_for_token(client, attributes)
  end

  # Identity

  def whoami(client) do
    identity_service.whoami(client)
  end

  # Domains

  def domains(account) do
    domain_service.all_domains(client(account), account.id)
  end

  # Client for account

  def client(account) do
    %Dnsimple.Client{access_token: account.dnsimple_access_token}
  end

  # Service modules

  defp oauth_service do
    Application.get_env(:hello_domains, :dnsimple_oauth_service, Dnsimple.OauthService)
  end

  defp identity_service do
    Application.get_env(:hello_domains, :dnsimple_identity_service, Dnsimple.IdentityService)
  end

  defp domain_service do
    Application.get_env(:hello_domains, :dnsimple_domains_service, Dnsimple.DomainsService)
  end
end
