defmodule SunnySideWeb.AccountLive.Components.Modal do
  use SunnySideWeb, :live_component

  alias SunnySide.{Account, Accounts}

  def update(params, socket) do
    socket =
      case params do
        %{account_number: account_number} ->
          socket
          |> assign(:account, Account.get_account_by_number(account_number))
          |> assign(:state, :edit)

        _ ->
          socket
          |> assign(:account, %Accounts{})
          |> assign(:state, :new)
      end

    socket
    |> account_changeset_to_form(socket.assigns.account)
    |> IO.inspect(label: "Socket")
    |> ok()
  end

  def mount(socket) do
    socket
    |> ok()
  end

  def handle_event(
        "create_or_edit",
        %{"account" => params},
        %{assigns: %{account: account}} = socket
      ) do
    socket =
      case Account.add_or_update_account(account, params) do
        {:ok, account} ->
          socket
          |> assign(:account, account)
          |> push_navigate(to: "/accounts")
          |> put_flash(
            :info,
            "Account #{if socket.assigns.state == :edit, do: "updated", else: "created"} successfully"
          )

        {:error, changeset} ->
          socket
          |> account_changeset_to_form(changeset)
          |> put_flash(
            :error,
            "Error #{if socket.assigns.state == :edit, do: "updating", else: "creating"} account"
          )
      end

    socket
    |> noreply()
  end

  def handle_event(
        "delete",
        _params,
        %{assigns: %{account: %{account_number: account_number}}} = socket
      ) do
    socket =
      case Account.delete_account_by_number(account_number) do
        {:ok, _} ->
          socket
          |> push_navigate(to: "/accounts")
          |> put_flash(:info, "Account deleted successfully")

        {:error, _} ->
          socket
          |> put_flash(:error, "Error deleting account")
      end

    socket
    |> noreply()
  end

  defp account_changeset_to_form(socket, changeset) do
    form =
      Ecto.Changeset.change(changeset)
      |> Map.put(:action, :validate)
      |> to_form(as: :account)

    socket
    |> assign(:form, form)
  end
end
