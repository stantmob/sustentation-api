defmodule Sustentation.Factories do
  # with Ecto
  use ExMachina.Ecto, repo: Sustentation.Repo

  def user_factory do
    %Sustentation.Auth.User{
      login: sequence(:email, &"email-#{&1}@example.com"),
      encrypted_password: Bcrypt.hash_pwd_salt("senhasenha")
    }
  end

  def category_factory do
    %Sustentation.Issues.Category{
      name: "Problema Web",
      description: "Erro no sistema web."
    }
  end
end
