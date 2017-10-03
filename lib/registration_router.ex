defmodule RegistrationRouter do
  use Plug.Router

  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug :match
  plug :dispatch

  # Displays a username/password
  # registration form
  get "/" do
    conn
    |> send_resp(200, [])
  end

  ###
  post "/" do
    conn
    |> send_resp(201, [])
  end
end
