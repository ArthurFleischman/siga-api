defmodule Siga.EntitiesTest do
  use Siga.DataCase

  alias Siga.Entities

  describe "subjects" do
    alias Siga.Entities.Subject

    @valid_attrs %{hours: 42, name: "some name", professor: "some professor"}
    @update_attrs %{hours: 43, name: "some updated name", professor: "some updated professor"}
    @invalid_attrs %{hours: nil, name: nil, professor: nil}

    def subject_fixture(attrs \\ %{}) do
      {:ok, subject} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_subject()

      subject
    end

    test "list_subjects/0 returns all subjects" do
      subject = subject_fixture()
      assert Entities.list_subjects() == [subject]
    end

    test "get_subject!/1 returns the subject with given id" do
      subject = subject_fixture()
      assert Entities.get_subject!(subject.id) == subject
    end

    test "create_subject/1 with valid data creates a subject" do
      assert {:ok, %Subject{} = subject} = Entities.create_subject(@valid_attrs)
      assert subject.hours == 42
      assert subject.name == "some name"
      assert subject.professor == "some professor"
    end

    test "create_subject/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_subject(@invalid_attrs)
    end

    test "update_subject/2 with valid data updates the subject" do
      subject = subject_fixture()
      assert {:ok, %Subject{} = subject} = Entities.update_subject(subject, @update_attrs)
      assert subject.hours == 43
      assert subject.name == "some updated name"
      assert subject.professor == "some updated professor"
    end

    test "update_subject/2 with invalid data returns error changeset" do
      subject = subject_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_subject(subject, @invalid_attrs)
      assert subject == Entities.get_subject!(subject.id)
    end

    test "delete_subject/1 deletes the subject" do
      subject = subject_fixture()
      assert {:ok, %Subject{}} = Entities.delete_subject(subject)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_subject!(subject.id) end
    end

    test "change_subject/1 returns a subject changeset" do
      subject = subject_fixture()
      assert %Ecto.Changeset{} = Entities.change_subject(subject)
    end
  end

  describe "requirements" do
    alias Siga.Entities.Requirements

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def requirements_fixture(attrs \\ %{}) do
      {:ok, requirements} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_requirements()

      requirements
    end

    test "list_requirements/0 returns all requirements" do
      requirements = requirements_fixture()
      assert Entities.list_requirements() == [requirements]
    end

    test "get_requirements!/1 returns the requirements with given id" do
      requirements = requirements_fixture()
      assert Entities.get_requirements!(requirements.id) == requirements
    end

    test "create_requirements/1 with valid data creates a requirements" do
      assert {:ok, %Requirements{} = requirements} = Entities.create_requirements(@valid_attrs)
    end

    test "create_requirements/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_requirements(@invalid_attrs)
    end

    test "update_requirements/2 with valid data updates the requirements" do
      requirements = requirements_fixture()

      assert {:ok, %Requirements{} = requirements} =
               Entities.update_requirements(requirements, @update_attrs)
    end

    test "update_requirements/2 with invalid data returns error changeset" do
      requirements = requirements_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Entities.update_requirements(requirements, @invalid_attrs)

      assert requirements == Entities.get_requirements!(requirements.id)
    end

    test "delete_requirements/1 deletes the requirements" do
      requirements = requirements_fixture()
      assert {:ok, %Requirements{}} = Entities.delete_requirements(requirements)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_requirements!(requirements.id) end
    end

    test "change_requirements/1 returns a requirements changeset" do
      requirements = requirements_fixture()
      assert %Ecto.Changeset{} = Entities.change_requirements(requirements)
    end
  end
end
