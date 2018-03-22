defmodule Routes.Main do
  use Plug.Router

  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug Plug.Logger
  plug Plug.Static,
       at: "/assets",
       from: Path.join([System.get_env("HOME"), "Projects/oauth2_server/lib/assets"])
  plug :match
  plug Plug.Parsers, parsers: [:json],
                     pass:  ["application/vnd.api+json"],
                     json_decoder: Poison
  plug :dispatch


  get "/" do
    conn
    |> put_resp_content_type("application/vnd.api+json")
    |> send_resp(200, Poison.encode!(%{
        "jsonapi" => %{
          "version" => "1.0"
        },
        "meta" => %{
          "title" => "Oauth 2.0 Server"
        }
    }))
  end

  get "/heartbeat" do
    {:ok, msg} = Poison.encode(%{
      "meta" => %{
        "status" => "200",
        "title" => "Heartbeat"
      }
    })
    conn
      |> put_resp_content_type("application/vnd.api+json")
      |> send_resp(200, msg)
  end

  forward "/registration", to: Routes.Registration

  match _ do
    {:ok, msg} = Poison.encode(%{
      "errors" => [%{
        "status" => "404",
        "title" => "Not Found"
      }]
    })
    conn
    |> put_resp_content_type("application/vnd.api+json")
    |> send_resp(404, msg)
  end

end
