defmodule SunnySide.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :account_name, :string
      add :account_number, :string
      add :payout_bank, :string
      add :payout_currency, :string
      add :payout_amount, :string
      add :status, :string
    end

    create unique_index(:accounts, [:account_number])
  end
end
