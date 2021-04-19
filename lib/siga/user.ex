defmodule Sysdev.User do
  @moduledoc """
  The User context.
  """

  import Ecto.Query, warn: false
  alias Sysdev.Repo

  alias Sysdev.User.Student

  @doc """
  Returns the list of student.

  ## Examples

      iex> list_student()
      [%Student{}, ...]

  """
  def list_student do
    Repo.all(Student)
  end

  @doc """
  Gets a single student.

  Raises `Ecto.NoResultsError` if the Student does not exist.

  ## Examples

      iex> get_student!(123)
      %Student{}

      iex> get_student!(456)
      ** (Ecto.NoResultsError)

  """
  def get_student!(id), do: Repo.get!(Student, id)

  @doc """
  Creates a student.

  ## Examples

      iex> create_student(%{field: value})
      {:ok, %Student{}}

      iex> create_student(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_student(attrs \\ %{}) do
    %Student{}
    |> Student.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a student.

  ## Examples

      iex> update_student(student, %{field: new_value})
      {:ok, %Student{}}

      iex> update_student(student, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_student(%Student{} = student, attrs) do
    student
    |> Student.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a student.

  ## Examples

      iex> delete_student(student)
      {:ok, %Student{}}

      iex> delete_student(student)
      {:error, %Ecto.Changeset{}}

  """
  def delete_student(%Student{} = student) do
    Repo.delete(student)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking student changes.

  ## Examples

      iex> change_student(student)
      %Ecto.Changeset{data: %Student{}}

  """
  def change_student(%Student{} = student, attrs \\ %{}) do
    Student.changeset(student, attrs)
  end

  alias Sysdev.User.Professor

  @doc """
  Returns the list of professor.

  ## Examples

      iex> list_professor()
      [%Professor{}, ...]

  """
  def list_professor do
    Repo.all(Professor)
  end

  @doc """
  Gets a single professor.

  Raises `Ecto.NoResultsError` if the Professor does not exist.

  ## Examples

      iex> get_professor!(123)
      %Professor{}

      iex> get_professor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_professor!(id), do: Repo.get!(Professor, id)

  @doc """
  Creates a professor.

  ## Examples

      iex> create_professor(%{field: value})
      {:ok, %Professor{}}

      iex> create_professor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_professor(attrs \\ %{}) do
    %Professor{}
    |> Professor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a professor.

  ## Examples

      iex> update_professor(professor, %{field: new_value})
      {:ok, %Professor{}}

      iex> update_professor(professor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_professor(%Professor{} = professor, attrs) do
    professor
    |> Professor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a professor.

  ## Examples

      iex> delete_professor(professor)
      {:ok, %Professor{}}

      iex> delete_professor(professor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_professor(%Professor{} = professor) do
    Repo.delete(professor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking professor changes.

  ## Examples

      iex> change_professor(professor)
      %Ecto.Changeset{data: %Professor{}}

  """
  def change_professor(%Professor{} = professor, attrs \\ %{}) do
    Professor.changeset(professor, attrs)
  end
end
