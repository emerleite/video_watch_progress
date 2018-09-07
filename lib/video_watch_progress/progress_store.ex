defmodule VideoWatchProgress.ProgressStore do
  alias VideoWatchProgress.ProgressTrack
  alias VideoWatchProgress.Repo

  require Logger

  def save(progress_data) do
    ProgressTrack.changeset(%ProgressTrack{}, progress_data)
    |> Repo.insert(on_conflict: ProgressTrack.insert_conflict_strategy(progress_data))
    |> process_result
  end

  def process_result({:ok, data}) do
    Logger.debug(inspect(data))
    :ok
  end

  def process_result({:error, changeset}) do
    Logger.info(inspect(changeset))
    :error
  end
end
