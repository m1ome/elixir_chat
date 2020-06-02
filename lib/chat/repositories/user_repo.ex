defmodule Chat.Repositories.UserRepo do
  import Ecto.Query

  alias Chat.Schemas.UserSchema
  alias Chat.Repo

  @spec find_by_email(binary) :: %UserSchema{} | nil
  def find_by_email(email) do
    (from u in UserSchema, where: u.email == ^email)
    |> Repo.one()
  end

  @spec create(binary, binary, binary) :: {:ok, %UserSchema{}} | {:error, Ecto.Changeset.t()}
  def create(email, password, nickname) do
    UserSchema.create_changeset(%{
      email: email,
      password: password,
      nickname: nickname
    }) |> Repo.insert()
  end
end
