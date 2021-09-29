defmodule Siga.AssetsTest do
  use Siga.DataCase

  alias Siga.Assets

  describe "profile_pic" do
    alias Siga.Assets.ProfilePic

    @valid_attrs %{filename: "some filename"}
    @update_attrs %{filename: "some updated filename"}
    @invalid_attrs %{filename: nil}

    def profile_pic_fixture(attrs \\ %{}) do
      {:ok, profile_pic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Assets.create_profile_pic()

      profile_pic
    end

    test "list_profile_pic/0 returns all profile_pic" do
      profile_pic = profile_pic_fixture()
      assert Assets.list_profile_pic() == [profile_pic]
    end

    test "get_profile_pic!/1 returns the profile_pic with given id" do
      profile_pic = profile_pic_fixture()
      assert Assets.get_profile_pic!(profile_pic.id) == profile_pic
    end

    test "create_profile_pic/1 with valid data creates a profile_pic" do
      assert {:ok, %ProfilePic{} = profile_pic} = Assets.create_profile_pic(@valid_attrs)
      assert profile_pic.filename == "some filename"
    end

    test "create_profile_pic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Assets.create_profile_pic(@invalid_attrs)
    end

    test "update_profile_pic/2 with valid data updates the profile_pic" do
      profile_pic = profile_pic_fixture()
      assert {:ok, %ProfilePic{} = profile_pic} = Assets.update_profile_pic(profile_pic, @update_attrs)
      assert profile_pic.filename == "some updated filename"
    end

    test "update_profile_pic/2 with invalid data returns error changeset" do
      profile_pic = profile_pic_fixture()
      assert {:error, %Ecto.Changeset{}} = Assets.update_profile_pic(profile_pic, @invalid_attrs)
      assert profile_pic == Assets.get_profile_pic!(profile_pic.id)
    end

    test "delete_profile_pic/1 deletes the profile_pic" do
      profile_pic = profile_pic_fixture()
      assert {:ok, %ProfilePic{}} = Assets.delete_profile_pic(profile_pic)
      assert_raise Ecto.NoResultsError, fn -> Assets.get_profile_pic!(profile_pic.id) end
    end

    test "change_profile_pic/1 returns a profile_pic changeset" do
      profile_pic = profile_pic_fixture()
      assert %Ecto.Changeset{} = Assets.change_profile_pic(profile_pic)
    end
  end
end
