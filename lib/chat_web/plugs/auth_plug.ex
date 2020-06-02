defmodule ChatWeb.AuthPlug do
  def init(opts) do
    opts
  end
#
  def call(%{assigns: %{user_signed_in?: true}} = conn, _params), do: conn
  def call(conn, _params) do
    conn
    |> Phoenix.Controller.redirect(to: "/signin")
  end
end
