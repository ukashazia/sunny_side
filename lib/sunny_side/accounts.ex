defmodule SunnySide.Accounts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :account_name, :string
    field :account_number, :string
    field :payout_bank, :string
    field :payout_currency, :string
    field :payout_amount, :string
    field :status, :string
  end

  def changeset(account, params \\ %{}) do
    account
    |> cast(params, [
      :account_name,
      :account_number,
      :payout_bank,
      :payout_currency,
      :payout_amount,
      :status
    ])
    |> validate_required([
      :account_name,
      :account_number,
      :payout_bank,
      :payout_currency,
      :payout_amount,
      :status
    ])
    |> unique_constraint(:account_number, message: "Account number already exists")
    |> validate_length(:account_number,
      min: 10,
      max: 10,
      message: "Account number must be 10 digits"
    )
    |> validate_length(:payout_amount,
      min: 1,
      max: 10,
      message: "Payout amount must be between 1 and 10 digits"
    )
  end
end
