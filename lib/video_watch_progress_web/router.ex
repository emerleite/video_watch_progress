defmodule VideoWatchProgressWeb.Router do
  use VideoWatchProgressWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", VideoWatchProgressWeb do
    pipe_through(:api)

    post("/progress", ProgressTrackController, :track_progress)
    get("/progress/:video_id", ProgressTrackController, :get_progress)
  end
end
