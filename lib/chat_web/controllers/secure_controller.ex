defmodule ChatWeb.SecureController do
  use ChatWeb, :controller

  def index(conn, _params) do
    # IO.inspect(conn)

    conn
    |> render("index.html", username: fetch_username(conn))
  end
end
