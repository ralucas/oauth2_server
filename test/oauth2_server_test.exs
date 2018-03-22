defmodule Oauth2ServerTest do
  use ExUnit.Case, async: true
  use Plug.Test
  doctest Oauth2Server

  @opts Routes.Main.init([])

  test "GET / returns 200 and has correct data" do
    conn = conn(:get, "/")

    # Invoke the plug
    conn = Routes.Main.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200

    content_type = Plug.Conn.get_resp_header(conn, "content-type") |> List.last
    assert Regex.match?(~r/application\/vnd\.api\+json/, content_type)

    {:ok, resp} = conn.resp_body |> Poison.Parser.parse
    title = get_in(resp, ["meta"]) |> get_in(["title"])
    assert title == "Oauth 2.0 Server"

    version= get_in(resp, ["jsonapi"]) |> get_in(["version"])
    assert version == "1.0"

  end

  test "GET /heartbeat returns 200" do
    # Create a test connection
    conn = conn(:get, "/heartbeat")

    # Invoke the plug
    conn = Routes.Main.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200

    content_type = Plug.Conn.get_resp_header(conn, "content-type") |> List.last
    assert Regex.match?(~r/application\/vnd\.api\+json/, content_type)

    {:ok, resp} = conn.resp_body |> Poison.Parser.parse
    title = get_in(resp, ["meta"]) |> get_in(["title"])
    assert title == "Heartbeat"
  end
end
