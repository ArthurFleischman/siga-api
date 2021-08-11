defmodule Siga.AccountsTest do
  use Siga.DataCase

  alias Siga.Accounts

  describe "users" do
    alias Siga.Accounts.User

    @valid_attrs %{birthdate: ~D[2010-04-17], cpf: "some cpf", email: "some email", freashman: ~D[2010-04-17], name: "some name", password: "some password", phone: "some phone", role: "some role"}
    @update_attrs %{birthdate: ~D[2011-05-18], cpf: "some updated cpf", email: "some updated email", freashman: ~D[2011-05-18], name: "some updated name", password: "some updated password", phone: "some updated phone", role: "some updated role"}
    @invalid_attrs %{birthdate: nil, cpf: nil, email: nil, freashman: nil, name: nil, password: nil, phone: nil, role: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.birthdate == ~D[2010-04-17]
      assert user.cpf == "some cpf"
      assert user.email == "some email"
      assert user.freashman == ~D[2010-04-17]
      assert user.name == "some name"
      assert user.password == "some password"
      assert user.phone == "some phone"
      assert user.role == "some role"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.birthdate == ~D[2011-05-18]
      assert user.cpf == "some updated cpf"
      assert user.email == "some updated email"
      assert user.freashman == ~D[2011-05-18]
      assert user.name == "some updated name"
      assert user.password == "some updated password"
      assert user.phone == "some updated phone"
      assert user.role == "some updated role"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
