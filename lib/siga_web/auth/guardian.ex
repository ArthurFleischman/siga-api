defmodule SigaWeb.Guardian do
  use Guardian, otp_app: :siga

  # def sign_user() do
  #   # {:ok, token, full_claims}
  #   Guardian.encode_and_sign(:access, nil, %{app_name: "siga"})
  # end

  # def auth_user_token(token) do
  #   # {:ok, claims}
  #   MyApp.Guardian.decode_and_verify(token)
  # end

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  # def subject_for_token(_, _) do
  #   {:error, :reason_for_error}
  # end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = SigaWeb.get_resource_by_id(id)
    {:ok, resource}
  end

  # def resource_from_claims(_claims) do
  #   {:error, :reason_for_error}
  #   # end
  # end
end
