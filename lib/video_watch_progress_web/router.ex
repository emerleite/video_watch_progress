defmodule VideoWatchProgressWeb.Router do
  use VideoWatchProgressWeb, :router

  pipeline :auth do
    plug(VideoWatchProgressWeb.UserAuth)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", VideoWatchProgressWeb do
    pipe_through(:api)
    pipe_through(:auth)

    post("/progress", ProgressTrackController, :track_progress)
    get("/progress/:video_id", ProgressTrackController, :get_progress)
  end
end
