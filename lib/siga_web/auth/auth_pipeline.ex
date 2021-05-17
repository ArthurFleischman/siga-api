defmodule SigaWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :siga,
    module: SigaWeb.Guardian,
    error_handler: SigaWeb.Guardian.AuthErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.Pipeline, error_handler: SigaWeb.Guardian.AuthErrorHandler
end
