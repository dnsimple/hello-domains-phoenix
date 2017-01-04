defmodule HelloDomains.Dnsimple.OauthMock do
  def exchange_authorization_for_token(_client, _attributes) do
    {:ok, %Dnsimple.Response{data: %{access_token: "access-token"}}}
  end
end

defmodule HelloDomains.Dnsimple.IdentityMock do
  def whoami(_access_token) do
    {:ok, %Dnsimple.Response{data: %{account: %{id: 1, email: "email@example.com"}}}}
  end
end

defmodule HelloDomains.Dnsimple.DomainsMock do
  def domains(_client, _account_id, _opts) do
    {:ok, %Dnsimple.Response{data: []}}
  end

  def all_domains(_client, _account_id) do
    {:ok, []}
  end

  def domain(_client, _account_id, name) do
    {:ok, %Dnsimple.Response{data: %Dnsimple.Domain{name: name}}}
  end
end
