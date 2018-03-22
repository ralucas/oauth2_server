defmodule Routes.Registration do
  use Plug.Router
  require EEx
  require Path

  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug :match
  plug :dispatch

  # Displays a username/password
  # registration form
  get "/" do
    params = Application.get_env(:oauth2_server, :registration)
    html = EEx.eval_file(
      Path.expand("./lib/views/templates/registration.html.eex"),
      params
    )
    conn
      |> put_resp_content_type("text/html")
      |> send_resp(200, html)
  end

  ###
  post "/" do
    conn
      |> put_resp_content_type("application/vnd.api+json")
      |> send_resp(201, conn.body_params)
  end
end
