defmodule VideoWatchProgress.ProgressTrack do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  import Ecto.Changeset

  alias VideoWatchProgress.Repo

  schema "progress_track" do
    field(:video_id, :integer)
    field(:seconds_watched, :integer, default: 0)
    field(:fully_watched, :boolean, default: false)
    field(:last_track_timestamp, :integer)
    field(:user_id, :string)

    timestamps()
  end

  def insert_conflict_strategy(%{"fully_watched" => fully_watched}) do
    from(v in VideoWatchProgress.ProgressTrack,
      update: [
        set: [
          seconds_watched:
            fragment(
              "IF(last_track_timestamp < VALUES(last_track_timestamp), VALUES(seconds_watched), seconds_watched)"
            ),
          last_track_timestamp:
            fragment(
              "IF(last_track_timestamp < VALUES(last_track_timestamp), VALUES(last_track_timestamp), last_track_timestamp)"
            ),
          updated_at: ^ecto_time(),
          fully_watched: ^fully_watched
        ]
      ]
    )
  end

  def insert_conflict_strategy(_progress_track) do
    from(v in VideoWatchProgress.ProgressTrack,
      update: [
        set: [
          seconds_watched:
            fragment(
              "IF(last_track_timestamp < VALUES(last_track_timestamp), VALUES(seconds_watched), seconds_watched)"
            ),
          last_track_timestamp:
            fragment(
              "IF(last_track_timestamp < VALUES(last_track_timestamp), VALUES(last_track_timestamp), last_track_timestamp)"
            ),
          updated_at: ^ecto_time()
        ]
      ]
    )
  end

  @doc false
  def changeset(progress_track, attrs) do
    progress_track
    |> cast(attrs, [:video_id, :seconds_watched, :fully_watched, :last_track_timestamp, :user_id])
    |> unique_constraint(:video_id, name: :progress_track_user_id_video_id_index)
    |> validate_required([
      :video_id,
      :seconds_watched,
      :last_track_timestamp,
      :user_id
    ])
  end

  defp ecto_time do
    timestamp = {_, _, usec} = :os.timestamp()
    NaiveDateTime.from_erl!(:calendar.now_to_datetime(timestamp), usec)
  end
end
