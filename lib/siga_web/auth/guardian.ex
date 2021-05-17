defmodule SigaWeb.Guardian do
  use Guardian, otp_app: :siga
  alias Siga.Entities

  # def sign_user() do
  #   # {:ok, token, full_claims}
  #   Guardian.encode_and_sign(:access, nil, %{app_name: "siga"})
  # end

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  # def subject_for_token(_resources, _claims) do
  #   {:error, :reason_for_error}
  # end

  @spec resource_from_claims(nil | maybe_improper_list | map) :: {:ok, any}
  def resource_from_claims(claims) do
    resource = Entities.get_user!(claims["sub"])
    {:ok, resource}
  end
end
