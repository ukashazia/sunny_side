defmodule SunnySide.Account do
  alias SunnySide.{Repo, Accounts}
  import Ecto.Query

  def list_accounts do
    from(a in Accounts, order_by: [desc: a.inserted_at, desc: a.updated_at])
    |> Repo.all()
  end

  def create_account(params) do
    %Accounts{}
    |> Accounts.changeset(params)
    |> Repo.insert()
  end

  def update_account(id, params) do
    Accounts
    |> Repo.get(id)
    |> Accounts.changeset(params)
    |> Repo.update()
  end

  def delete_account_by_number(number) do
    Accounts
    |> Repo.get_by(account_number: number)
    |> Repo.delete()
  end

  def get_account_by_number(account_number) do
    Accounts
    |> Repo.get_by(account_number: account_number)
  end

  def add_or_update_account(account, params) do
    account
    |> Accounts.changeset(params)
    |> Repo.insert_or_update()
  end
end
