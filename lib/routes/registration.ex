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
    {_, _, [_, html]} = EEx.compile_file(Path.expand("./lib/views/templates/registration.html.eex"))
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  ###
  post "/" do
    Controllers.Registration.create(conn)
  end
end
