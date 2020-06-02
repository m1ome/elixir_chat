defmodule Chat.Schemas.UserSchema do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :nickname, :string

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:email, :password, :nickname])
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [:email, :password, :nickname])
    |> put_password_hash()
    |> validate_required([:email, :password_hash, :nickname])
    |> unique_constraint(:email)
  end

  defp put_password_hash(%{changes: %{password: password}} = changeset) do
    changeset
    |> put_change(:password_hash, Bcrypt.Base.hash_password(password, Bcrypt.gen_salt(12, true)))
  end
end
