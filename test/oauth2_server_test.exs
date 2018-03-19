defmodule Oauth2ServerTest do
  use ExUnit.Case, async: true
  use Plug.Test
  doctest Oauth2Server

  @opts Routes.Main.init([])

  test "returns hello world" do
    # Create a test connection
    conn = conn(:get, "/hello")

    # Invoke the plug
    conn = Routes.Main.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "world"
  end
end
