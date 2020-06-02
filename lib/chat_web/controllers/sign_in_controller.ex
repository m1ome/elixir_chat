defmodule ChatWeb.SigninController do
  use ChatWeb, :controller

  alias Chat.Repositories.UserRepo

  def index(conn, _params) do
    conn
    |> render("index.html")
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    with %{password_hash: password_hash, id: user_id, nickname: username} <- UserRepo.find_by_email(email),
      {:password_valid?, true} <- {:password_valid?, Bcrypt.verify_pass(password, password_hash)} do
        conn
        |> put_session(:user_id, user_id)
        |> put_session(:username, username)
        |> redirect(to: "/secure")
      else
        nil ->
          Bcrypt.no_user_verify()
          conn
          |> put_flash(:error, "Wrong email/password")
          |> redirect(to: "/signin")

        {:password_valid?, false} ->
          conn
          |> put_flash(:error, "Wrong email/password")
          |> redirect(to: "/signin")
      end
  end

end
