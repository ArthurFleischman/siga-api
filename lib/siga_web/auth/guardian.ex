defmodule SigaWeb.Guardian do
  use Guardian, otp_app: :siga
  alias Guardian.DB

  alias Siga.Entities

  @spec subject_for_token(atom | %{:id => any, optional(any) => any}, any) :: {:ok, binary}
  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    IO.puts(sub)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    user = Entities.get_user!(claims["sub"])
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end

  # GUARDIAN DB

  def on_revoke(claims, token, _options) do
    DB.on_revoke(claims, token)
  end

  def after_encode_and_sign(resource, claims, token, _options) do
    IO.puts(claims["typ"])

    with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
      {:ok, token}
    end
  end

  def on_verify(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end

  def on_refresh({old_token, old_claims}, {new_token, new_claims}, _options) do
    with {:ok, _, _} <- Guardian.DB.on_refresh({old_token, old_claims}, {new_token, new_claims}) do
      {:ok, {old_token, old_claims}, {new_token, new_claims}}
    end
  end
end
