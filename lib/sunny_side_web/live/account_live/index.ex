defmodule SunnySideWeb.AccountLive.Index do
  use SunnySideWeb, :live_view
  alias SunnySide.Account
  alias SunnySideWeb.AccountLive.Components.Modal

  def mount(_params, _session, socket) do
    socket
    |> list_accounts()
    |> ok()
  end

  def handle_params(params, _uri, socket) do
    if params["account_number"],
      do:
        send_update(Modal, %{id: "edit-account-modal", account_number: params["account_number"]})

    socket
    |> noreply()
  end

  def handle_event("edit", %{"account_number" => account_number}, socket) do
    socket
    |> push_navigate(to: "/accounts/#{account_number}/edit")
    |> noreply()
  end

  def handle_event("new_account", _params, socket) do
    socket
    |> push_navigate(to: "/accounts/new")
    |> noreply()
  end

  defp list_accounts(socket) do
    socket
    |> assign(:accounts, Account.list_accounts())
  end
end
