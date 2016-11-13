defmodule Br.BoxScoreController do
  use Br.Web, :controller
  alias Br.BoxScore

  def create(conn, %{"box_score" => box_score}) do
    box_score = transform_data(box_score)
    changeset = BoxScore.changeset(%BoxScore{rushing_stats: [%Br.RushingStat{}]}, box_score)

    case Repo.insert(changeset) do
      {:ok, box_score} ->
        conn
        |> put_status(:created)
        |> render("created.json")
    end
  end

  defp transform_data(box_score) do
    box_score
    |> Enum.into(%{}, fn {k, v} -> transform_key(k, v) end)
  end

  defp transform_key(key, value) do
    cond do
      key in ["rushing", "receiving", "passing", "kicking"] -> {"#{key}_stats", value}
      true -> {Phoenix.Naming.underscore(key), value}
    end
  end
end