defmodule Siga.Assets do
  @moduledoc """
  The Assets context.
  """

  import Ecto.Query, warn: false
  alias Siga.Repo

  alias Siga.Assets.ProfilePic

  @doc """
  Returns the list of profile_pic.

  ## Examples

      iex> list_profile_pic()
      [%ProfilePic{}, ...]

  """
  def list_profile_pic do
    Repo.all(ProfilePic)
  end

  @doc """
  Gets a single profile_pic.

  Raises `Ecto.NoResultsError` if the Profile pic does not exist.

  ## Examples

      iex> get_profile_pic!(123)
      %ProfilePic{}

      iex> get_profile_pic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_profile_pic!(id), do: Repo.get!(ProfilePic, id)

  @doc """
  Creates a profile_pic.

  ## Examples

      iex> create_profile_pic(%{field: value})
      {:ok, %ProfilePic{}}

      iex> create_profile_pic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_profile_pic(attrs \\ %{}) do
    %ProfilePic{}
    |> ProfilePic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a profile_pic.

  ## Examples

      iex> update_profile_pic(profile_pic, %{field: new_value})
      {:ok, %ProfilePic{}}

      iex> update_profile_pic(profile_pic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_profile_pic(%ProfilePic{} = profile_pic, attrs) do
    profile_pic
    |> ProfilePic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a profile_pic.

  ## Examples

      iex> delete_profile_pic(profile_pic)
      {:ok, %ProfilePic{}}

      iex> delete_profile_pic(profile_pic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_profile_pic(%ProfilePic{} = profile_pic) do
    Repo.delete(profile_pic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking profile_pic changes.

  ## Examples

      iex> change_profile_pic(profile_pic)
      %Ecto.Changeset{data: %ProfilePic{}}

  """
  def change_profile_pic(%ProfilePic{} = profile_pic, attrs \\ %{}) do
    ProfilePic.changeset(profile_pic, attrs)
  end
end
