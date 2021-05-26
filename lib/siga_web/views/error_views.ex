defmodule SigaWeb.ErrorView do
  def render("500.json", reason) do
    %{errors: %{details: reason}}
  end

  def render("404.json", reason) do
    %{errors: %{details: reason}}
  end
end
