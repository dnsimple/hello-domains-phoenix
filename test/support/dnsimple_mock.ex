defmodule HelloDomains.Dnsimple.OauthMock do
  def exchange_authorization_for_token(_client, _attributes) do
    {:ok, %Dnsimple.Response{data: %{access_token: "access-token"}}}
  end
end

defmodule HelloDomains.Dnsimple.IdentityMock do
  def whoami(_client) do
    {:ok, %Dnsimple.Response{data: %{account: %{id: 1, email: "email@example.com"}}}}
  end
end

defmodule HelloDomains.Dnsimple.DomainsMock do
  def all_domains(_client, _account_id) do
    {:ok, []}
  end
end
