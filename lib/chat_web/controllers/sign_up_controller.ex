defmodule ChatWeb.SignupController do
  use ChatWeb, :controller

  alias Chat.Schemas.UserSchema
  alias Chat.Repositories.UserRepo

  def index(conn, _params) do
    IO.inspect(conn)
    changeset = UserSchema.changeset(%UserSchema{})

    conn
    |> render("index.html", changeset: changeset)
  end

  def create(conn, %{"user_schema" => %{"email" => email, "password" => password, "nickname" => nickname}}) do
    case UserRepo.create(email, password, nickname) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Created new user #{nickname}")
        |> redirect(to: "/signin")

      {:error, reason} ->
        conn
        |> put_flash(:error, "Error creating new user: #{inspect reason}")
        |> redirect(to: "/signup")
    end
  end

  def create(conn, _) do
    conn
    |> put_flash(:error, "Bad request")
    |> redirect(to: "/signup")
  end
end
