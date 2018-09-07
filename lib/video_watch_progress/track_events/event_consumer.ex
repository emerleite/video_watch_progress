defmodule VideoWatchProgress.EventConsumer do
  use ConsumerSupervisor

  def start_link(%{producer: producer, processor: processor}) do
    children = [
      worker(processor, [], restart: :temporary)
    ]

    ConsumerSupervisor.start_link(children,
      strategy: :one_for_one,
      subscribe_to: [
        {
          producer,
          min_demand: Application.get_env(:video_watch_progress, :events_min_demand),
          max_demand: Application.get_env(:video_watch_progress, :events_max_demand)
        }
      ]
    )
  end
end
