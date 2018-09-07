defmodule VideoWatchProgress.EventAggregator do
  alias VideoWatchProgress.ProgressStore

  def start_link(event) do
    Task.start_link(fn ->
      ProgressStore.save(event)
    end)
  end
end
