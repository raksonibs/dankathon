defmodule Backend.Repo do
  use Ecto.Repo, otp_app: :backend
  use Scrivener, page_size: 12
end
