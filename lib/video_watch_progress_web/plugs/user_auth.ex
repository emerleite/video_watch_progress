defmodule VideoWatchProgressWeb.UserAuth do
  @moduledoc false

  import Plug.Conn

  @conn_key :user_id

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> authorize()
    |> respond_with()
  end

  def get_user_id(conn), do: conn.assigns[@conn_key]

  defp authorize(conn) do
    conn
    |> get_token
    |> get_user()
    |> store_user(conn)
  end

  defp get_token(conn), do: Map.get(conn.params, "token")

  defp get_user(nil), do: nil

  # Dummy user find my auth token
  defp get_user(token) do
    %{"valid_token" => "abc", "invalid_token" => nil}
    |> Map.get(token, nil)
  end

  defp store_user(nil, conn), do: {:error, :invalid_token, conn}

  defp store_user(user_id, conn) do
    {:ok, assign(conn, @conn_key, user_id)}
  end

  defp respond_with({:error, :invalid_token, conn}), do: respond_unauthorized(conn)

  defp respond_with({:ok, conn}), do: conn

  defp respond_unauthorized(conn) do
    conn
    |> send_resp(401, Poison.encode!(%{error: %{message: "unauthorized user", status: 401}}))
    |> halt()
  end
end
