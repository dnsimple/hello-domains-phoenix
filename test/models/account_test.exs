defmodule HelloDomains.AccountTest do
  use HelloDomains.ModelCase, async: true

  alias HelloDomains.Account

  @valid_attrs %{
    dnsimple_account_id: "101",
    dnsimple_account_email: "john.doe@example.com",
    dnsimple_access_token: "dnsimple-token"
  }

  test "create with valid attributes" do
    {:ok, account} = Account.create(%Account{}, @valid_attrs) 
    assert account.dnsimple_account_id == @valid_attrs[:dnsimple_account_id]
    assert Repo.get(Account, account.id) == account
  end

  test "create! with valid attributes" do
    account = Account.create!(%Account{}, @valid_attrs)
    assert account.dnsimple_account_id == @valid_attrs[:dnsimple_account_id]
    assert Repo.get(Account, account.id) == account
  end

  test "get" do
    account = Account.create!(%Account{}, @valid_attrs)
    assert Account.get(account.id) == account
  end

  test "get with no record returns nil" do
    assert Account.get(0) == nil
  end

  test "get!" do
    account = Account.create!(%Account{}, @valid_attrs)
    assert Account.get!(account.id) == account
  end

  test "get! with no record raises an error" do
    assert_raise(Ecto.NoResultsError, fn() ->
      Account.get!(0)
    end)
  end

  test "find or create with valid dnsimple account id" do
    {:ok, account} = Account.find_or_create(@valid_attrs[:dnsimple_account_id])
    assert account.dnsimple_account_id == @valid_attrs[:dnsimple_account_id]
    assert Repo.get(Account, account.id) == account
  end

  test "find or create! with valid dnsimple_account_id" do
    account = Account.find_or_create!(@valid_attrs[:dnsimple_account_id])
    assert account.dnsimple_account_id == @valid_attrs[:dnsimple_account_id]
    assert Repo.get(Account, account.id) == account
  end

  test "find or create with additional params" do
    access_token = "a-token"
    {:ok, account} = Account.find_or_create(@valid_attrs[:dnsimple_account_id], %{"dnsimple_access_token" => access_token})
    assert account.dnsimple_account_id == @valid_attrs[:dnsimple_account_id]
    assert account.dnsimple_access_token == access_token
    assert Repo.get(Account, account.id) == account
  end

  test "find or create! with additional params" do
    access_token = "a-token"
    account = Account.find_or_create!(@valid_attrs[:dnsimple_account_id], %{"dnsimple_access_token" => access_token})
    assert account.dnsimple_account_id == @valid_attrs[:dnsimple_account_id]
    assert account.dnsimple_access_token == access_token
    assert Repo.get(Account, account.id) == account
  end

  test "update with valid attributes" do
    new_email = "another-email@example.com"
    account = Account.create!(%Account{}, @valid_attrs)
    changeset = Account.changeset(account, %{@valid_attrs| dnsimple_account_email: new_email})
    {:ok, account} = Account.update(changeset)
    assert account.dnsimple_account_email == new_email
  end

  test "update! with valid attributes" do
    new_email = "another-email@example.com"
    account = Account.create!(%Account{}, @valid_attrs)
    changeset = Account.changeset(account, %{@valid_attrs| dnsimple_account_email: new_email})
    account = Account.update!(changeset)
    assert account.dnsimple_account_email == new_email
  end

  test "delete" do
    account = Account.create!(%Account{}, @valid_attrs)
    {:ok, account} = Account.delete(account)
    assert Repo.get(Account, account.id) == nil
  end

end
