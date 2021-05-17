defmodule SigaWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :siga,
    module: SigaWeb.Guardian,
    error_hanlder: SigaWeb.Guardian.AuthErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated, %{"typ" => "access", handler: :error_handler}
end
