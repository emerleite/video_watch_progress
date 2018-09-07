defmodule VideoWatchProgress.ProgressStore do
  alias VideoWatchProgress.ProgressTrack
  alias VideoWatchProgress.Repo

  import Ecto.Query, only: [from: 2]

  require Logger

  def get(%{"video_id" => video_id, "user_id" => user_id}) do
    from(p in ProgressTrack,
      where: p.video_id == ^video_id and p.user_id == ^user_id,
      select: p.seconds_watched
    )
    |> Repo.one()
  end

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
