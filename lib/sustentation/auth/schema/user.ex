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

  @spec encrypt_password(Ecto.Changeset.t()) :: Ecto.Changeset.t()

  def encrypt_password(changeset) do
    with %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset <- changeset do
      put_change(changeset, :encrypted_password, Bcrypt.hash_pwd_salt(password))
    end
  end
end
