# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SunnySide.Repo.insert!(%SunnySide.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SunnySide.{Accounts, Repo}

#  create 10  seed records for accounts

Enum.each(1..50, fn _ ->
  Repo.insert(%Accounts{
    account_name: Faker.Person.name(),
    account_number: Enum.random(10_000_000_000..99_999_999_999) |> Integer.to_string(),
    payout_bank: Faker.Company.name(),
    payout_currency: Faker.Currency.code(),
    payout_amount: Enum.random(1..99_999_999_999) |> Integer.to_string(),
    status: Enum.random([:active, :inactive, :pending]) |> Atom.to_string()
  })
end)
