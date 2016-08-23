defmodule HelloDomains.Dnsimple.OauthServiceMock do
  def exchange_authorization_for_token(_client, _attributes) do
    {:ok, %Dnsimple.Response{data: %{access_token: "access-token"}}}
  end
end

defmodule HelloDomains.Dnsimple.IdentityServiceMock do
  def whoami(_client) do
    {:ok, %Dnsimple.Response{data: %{account: %{"id" => 1}}}}
  end
end

defmodule HelloDomains.Dnsimple.DomainsServiceMock do
  def domains(_client, _account_id, _opts) do
    {:ok, %Dnsimple.Response{data: []}}
  end

  def all_domains(_client, _account_id) do
    []
  end

  def domain(_client, _account_id, name) do
    {:ok, %Dnsimple.Response{data: %Dnsimple.Domain{name: name}}}
  end
end
