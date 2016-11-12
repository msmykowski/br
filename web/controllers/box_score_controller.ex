defmodule Br.BoxScoreController do
  use Br.Web, :controller
  alias Br.BoxScore

  def create(conn, %{"box_score" => box_score}) do
    box_score = box_score
      |> Enum.into(%{}, fn {k, v} -> {Phoenix.Naming.underscore(k), v} end)

    changeset = BoxScore.changeset(%BoxScore{}, box_score)
    case Repo.insert(changeset) do
      {:ok, box_score} ->
        conn
        |> put_status(:created)
        |> render("created.json")
    end
  end
end