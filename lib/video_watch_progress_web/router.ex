defmodule VideoWatchProgressWeb.Router do
  use VideoWatchProgressWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", VideoWatchProgressWeb do
    pipe_through :api
  end
end
