defmodule VideoWatchProgress.Repo.Migrations.CreateProgressTrack do
  use Ecto.Migration

  def change do
    create table(:progress_track) do
      add(:video_id, :integer, null: false)
      add(:seconds_watched, :integer, null: false)
      add(:fully_watched, :boolean, default: false, null: false)
      add(:last_track_timestamp, :bigint)
      add(:user_id, :string, size: 40, null: false)

      timestamps()
    end

    create(unique_index(:progress_track, [:user_id, :video_id], concurrently: true))

    create(
      index(:progress_track, [:user_id, :updated_at],
        concurrently: true,
        name: "progress_track_user_updated_at_index"
      )
    )
  end
end
