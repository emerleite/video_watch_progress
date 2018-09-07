defmodule VideoWatchProgressWeb.ProgressTrackController do
  use VideoWatchProgressWeb, :controller

  alias VideoWatchProgress.EventStore
  alias VideoWatchProgress.ProgressStore
  alias VideoWatchProgressWeb.UserAuth

  require Logger

  def track_progress(conn, params) do
    Logger.info(inspect(conn))
    Logger.info(inspect(params))

    params
    |> Map.merge(%{"last_track_timestamp" => :os.system_time(:millisecond)})
    |> Map.merge(%{"user_id" => UserAuth.get_user_id(conn)})
    |> EventStore.enqueue()

    send_resp(conn, 200, "OK")
    json(conn, %{ok: true})
  end

  def get_progress(conn, params) do
    progress =
      params
      |> Map.merge(%{"user_id" => UserAuth.get_user_id(conn)})
      |> ProgressStore.get()

    json(conn, %{progress: progress})
  end
end
