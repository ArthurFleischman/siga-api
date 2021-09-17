defmodule SigaWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :siga,
    module: SigaWeb.Guardian,
    error_handler: SigaWeb.Guardian.AuthErrorHandler

  plug Guardian.Plug.Pipeline,
    module: SigaWeb.Guardian,
    error_handler: SigaWeb.Guardian.AuthErrorHandler

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, realm: "Bearer", claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
  plug Guardian.Plug.EnsureAuthenticated, claims: %{"typ" => "access"}
end
