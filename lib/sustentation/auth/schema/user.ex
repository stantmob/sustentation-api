defmodule Sustentation.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :encrypted_password, :string
    field :login, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:login, :password])
    |> validate_required([:login, :password])
    |> encrypt_password()
  end

  def encrypt_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :encrypted_password, Bcrypt.hash_pwd_salt(password))
  end
end
