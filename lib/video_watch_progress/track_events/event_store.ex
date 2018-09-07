defmodule VideoWatchProgress.EventStore do
  use GenStage

  require Logger

  # seconds
  @event_processing_timeout Application.get_env(:video_watch_progress, :event_ttl)

  def start_link() do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def enqueue(event) do
    GenStage.cast(__MODULE__, {:enqueue, event})
  end

  def init(:ok) do
    {:producer, {:queue.new(), 0, 0}, dispatcher: GenStage.BroadcastDispatcher}
  end

  def handle_cast({:enqueue, event}, {queue, demand, queue_size}) do
    dispatch_events(:queue.in(event, queue), demand, [], queue_size + 1)
  end

  def handle_demand(incoming_demand, {queue, demand, queue_size}) do
    dispatch_events(queue, incoming_demand + demand, [], queue_size)
  end

  defp dispatch_events(queue, demand, events, queue_size) do
    with d when d > 0 <- demand,
         {item, queue} = :queue.out(queue),
         {:value, event} <- item do
      case check_event(event) do
        :expired ->
          dispatch_events(queue, demand, events, queue_size - 1)

        :valid ->
          dispatch_events(queue, demand - 1, [event | events], queue_size - 1)
      end
    else
      _ -> {:noreply, Enum.reverse(events), {queue, demand, queue_size}}
    end
  end

  defp check_event(event) do
    if :os.system_time(:millisecond) >
         Map.get(event, "last_track_timestamp") + :timer.seconds(@event_processing_timeout) do
      :expired
    else
      :valid
    end
  end
end
