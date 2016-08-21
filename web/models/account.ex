defmodule HelloDomains.Account do
  use HelloDomains.Web, :model

  alias HelloDomains.Account

  schema "accounts" do
    field :dnsimple_account_id, :string
    field :dnsimple_account_email, :string
    field :dnsimple_access_token, :string
    timestamps
  end

  @required_fields ~w(dnsimple_account_id)
  @optional_fields ~w(dnsimple_account_email dnsimple_access_token)

  def create(model, params \\ %{}) do
    model
    |> changeset(params)
    |> Repo.insert
  end

  def create!(model, params \\ %{}) do
    model
    |> changeset(params)
    |> Repo.insert!
  end

  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def find_or_create(dnsimple_account_id, params \\ %{}) do
    case Repo.get_by(Account, dnsimple_account_id: dnsimple_account_id) do
      nil -> create(%Account{dnsimple_account_id: dnsimple_account_id}, params)
      account -> {:ok, account}
    end
  end

  def find_or_create!(dnsimple_account_id, params \\ %{}) do
    case Repo.get_by(Account, dnsimple_account_id: dnsimple_account_id) do
      nil -> create!(%Account{dnsimple_account_id: dnsimple_account_id}, params)
      account -> account
    end
  end

  def update(changeset) do
    Repo.update(changeset)
  end

  def update!(changeset) do
    Repo.update!(changeset)
  end

  def delete(model) do
    Repo.delete(model)
  end
end
