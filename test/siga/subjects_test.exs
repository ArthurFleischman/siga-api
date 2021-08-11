defmodule Siga.SubjectsTest do
  use Siga.DataCase

  alias Siga.Subjects

  describe "subjects" do
    alias Siga.Subjects.Subject

    @valid_attrs %{hours: 42, name: "some name"}
    @update_attrs %{hours: 43, name: "some updated name"}
    @invalid_attrs %{hours: nil, name: nil}

    def subject_fixture(attrs \\ %{}) do
      {:ok, subject} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Subjects.create_subject()

      subject
    end

    test "list_subjects/0 returns all subjects" do
      subject = subject_fixture()
      assert Subjects.list_subjects() == [subject]
    end

    test "get_subject!/1 returns the subject with given id" do
      subject = subject_fixture()
      assert Subjects.get_subject!(subject.id) == subject
    end

    test "create_subject/1 with valid data creates a subject" do
      assert {:ok, %Subject{} = subject} = Subjects.create_subject(@valid_attrs)
      assert subject.hours == 42
      assert subject.name == "some name"
    end

    test "create_subject/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Subjects.create_subject(@invalid_attrs)
    end

    test "update_subject/2 with valid data updates the subject" do
      subject = subject_fixture()
      assert {:ok, %Subject{} = subject} = Subjects.update_subject(subject, @update_attrs)
      assert subject.hours == 43
      assert subject.name == "some updated name"
    end

    test "update_subject/2 with invalid data returns error changeset" do
      subject = subject_fixture()
      assert {:error, %Ecto.Changeset{}} = Subjects.update_subject(subject, @invalid_attrs)
      assert subject == Subjects.get_subject!(subject.id)
    end

    test "delete_subject/1 deletes the subject" do
      subject = subject_fixture()
      assert {:ok, %Subject{}} = Subjects.delete_subject(subject)
      assert_raise Ecto.NoResultsError, fn -> Subjects.get_subject!(subject.id) end
    end

    test "change_subject/1 returns a subject changeset" do
      subject = subject_fixture()
      assert %Ecto.Changeset{} = Subjects.change_subject(subject)
    end
  end

  describe "requiirement" do
    alias Siga.Subjects.Requirement

    @valid_attrs %{type: "some type"}
    @update_attrs %{type: "some updated type"}
    @invalid_attrs %{type: nil}

    def requirement_fixture(attrs \\ %{}) do
      {:ok, requirement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Subjects.create_requirement()

      requirement
    end

    test "list_requiirement/0 returns all requiirement" do
      requirement = requirement_fixture()
      assert Subjects.list_requiirement() == [requirement]
    end

    test "get_requirement!/1 returns the requirement with given id" do
      requirement = requirement_fixture()
      assert Subjects.get_requirement!(requirement.id) == requirement
    end

    test "create_requirement/1 with valid data creates a requirement" do
      assert {:ok, %Requirement{} = requirement} = Subjects.create_requirement(@valid_attrs)
      assert requirement.type == "some type"
    end

    test "create_requirement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Subjects.create_requirement(@invalid_attrs)
    end

    test "update_requirement/2 with valid data updates the requirement" do
      requirement = requirement_fixture()
      assert {:ok, %Requirement{} = requirement} = Subjects.update_requirement(requirement, @update_attrs)
      assert requirement.type == "some updated type"
    end

    test "update_requirement/2 with invalid data returns error changeset" do
      requirement = requirement_fixture()
      assert {:error, %Ecto.Changeset{}} = Subjects.update_requirement(requirement, @invalid_attrs)
      assert requirement == Subjects.get_requirement!(requirement.id)
    end

    test "delete_requirement/1 deletes the requirement" do
      requirement = requirement_fixture()
      assert {:ok, %Requirement{}} = Subjects.delete_requirement(requirement)
      assert_raise Ecto.NoResultsError, fn -> Subjects.get_requirement!(requirement.id) end
    end

    test "change_requirement/1 returns a requirement changeset" do
      requirement = requirement_fixture()
      assert %Ecto.Changeset{} = Subjects.change_requirement(requirement)
    end
  end

  describe "requirement" do
    alias Siga.Subjects.Requirement

    @valid_attrs %{type: "some type"}
    @update_attrs %{type: "some updated type"}
    @invalid_attrs %{type: nil}

    def requirement_fixture(attrs \\ %{}) do
      {:ok, requirement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Subjects.create_requirement()

      requirement
    end

    test "list_requirement/0 returns all requirement" do
      requirement = requirement_fixture()
      assert Subjects.list_requirement() == [requirement]
    end

    test "get_requirement!/1 returns the requirement with given id" do
      requirement = requirement_fixture()
      assert Subjects.get_requirement!(requirement.id) == requirement
    end

    test "create_requirement/1 with valid data creates a requirement" do
      assert {:ok, %Requirement{} = requirement} = Subjects.create_requirement(@valid_attrs)
      assert requirement.type == "some type"
    end

    test "create_requirement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Subjects.create_requirement(@invalid_attrs)
    end

    test "update_requirement/2 with valid data updates the requirement" do
      requirement = requirement_fixture()
      assert {:ok, %Requirement{} = requirement} = Subjects.update_requirement(requirement, @update_attrs)
      assert requirement.type == "some updated type"
    end

    test "update_requirement/2 with invalid data returns error changeset" do
      requirement = requirement_fixture()
      assert {:error, %Ecto.Changeset{}} = Subjects.update_requirement(requirement, @invalid_attrs)
      assert requirement == Subjects.get_requirement!(requirement.id)
    end

    test "delete_requirement/1 deletes the requirement" do
      requirement = requirement_fixture()
      assert {:ok, %Requirement{}} = Subjects.delete_requirement(requirement)
      assert_raise Ecto.NoResultsError, fn -> Subjects.get_requirement!(requirement.id) end
    end

    test "change_requirement/1 returns a requirement changeset" do
      requirement = requirement_fixture()
      assert %Ecto.Changeset{} = Subjects.change_requirement(requirement)
    end
  end
end
