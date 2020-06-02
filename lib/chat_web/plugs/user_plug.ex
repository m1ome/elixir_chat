defmodule ChatWeb.UserPlug do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _params) do
    case get_session(conn, :username) do
      nil ->
        conn
        |> assign(:username, nil)
        |> assign(:user_signed_in?, false)

      username ->
        conn
        |> assign(:username, username)
        |> assign(:user_signed_in?, true)
    end
  end
end
