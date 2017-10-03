defmodule Oauth2Router do
  use Plug.Router

  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug :match
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

  forward "/registration", to: RegistrationRouter

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
