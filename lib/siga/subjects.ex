defmodule Siga.Subjects do
  @moduledoc """
  The Subjects context.
  """

  import Ecto.Query, warn: false
  alias Siga.Repo

  alias Siga.Subjects.Subject

  @doc """
  Returns the list of subjects.

  ## Examples

      iex> list_subjects()
      [%Subject{}, ...]

  """
  def list_subjects do
    Repo.all(Subject)
  end

  @doc """
  Gets a single subject.

  Raises `Ecto.NoResultsError` if the Subject does not exist.

  ## Examples

      iex> get_subject!(123)
      %Subject{}

      iex> get_subject!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subject!(id), do: Repo.get!(Subject, id)

  @doc """
  Creates a subject.

  ## Examples

      iex> create_subject(%{field: value})
      {:ok, %Subject{}}

      iex> create_subject(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_subject(attrs \\ %{}) do
    %Subject{}
    |> Subject.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a subject.

  ## Examples

      iex> update_subject(subject, %{field: new_value})
      {:ok, %Subject{}}

      iex> update_subject(subject, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subject(%Subject{} = subject, attrs) do
    subject
    |> Subject.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a subject.

  ## Examples

      iex> delete_subject(subject)
      {:ok, %Subject{}}

      iex> delete_subject(subject)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subject(%Subject{} = subject) do
    Repo.delete(subject)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking subject changes.

  ## Examples

      iex> change_subject(subject)
      %Ecto.Changeset{data: %Subject{}}

  """
  def change_subject(%Subject{} = subject, attrs \\ %{}) do
    Subject.changeset(subject, attrs)
  end

  alias Siga.Subjects.Requirement

  @doc """
  Returns the list of requiirement.

  ## Examples

      iex> list_requiirement()
      [%Requirement{}, ...]

  """
  def list_requirement do
    Repo.all(Requirement)
  end

  @doc """
  Gets a single requirement.

  Raises `Ecto.NoResultsError` if the Requirement does not exist.

  ## Examples

      iex> get_requirement!(123)
      %Requirement{}

      iex> get_requirement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_requirement!(id), do: Repo.get!(Requirement, id)

  @doc """
  Creates a requirement.

  ## Examples

      iex> create_requirement(%{field: value})
      {:ok, %Requirement{}}

      iex> create_requirement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_requirement(attrs \\ %{}) do
    %Requirement{}
    |> Requirement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a requirement.

  ## Examples

      iex> update_requirement(requirement, %{field: new_value})
      {:ok, %Requirement{}}

      iex> update_requirement(requirement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_requirement(%Requirement{} = requirement, attrs) do
    requirement
    |> Requirement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a requirement.

  ## Examples

      iex> delete_requirement(requirement)
      {:ok, %Requirement{}}

      iex> delete_requirement(requirement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_requirement(%Requirement{} = requirement) do
    Repo.delete(requirement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking requirement changes.

  ## Examples

      iex> change_requirement(requirement)
      %Ecto.Changeset{data: %Requirement{}}

  """
  def change_requirement(%Requirement{} = requirement, attrs \\ %{}) do
    Requirement.changeset(requirement, attrs)
  end
end
