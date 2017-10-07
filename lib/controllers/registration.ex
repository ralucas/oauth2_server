defmodule Controllers.Registration do
  @moduledoc false
  use Plug.Parsers

  def create(conn) do
    {:ok, body_params, conn} = parse(conn, "application/vnd.api+json", "json")
    conn
    |> put_resp_content_type("application/vnd.api+json")
    |> send_resp(201, body_params)
  end
  
end