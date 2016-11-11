defmodule Br.BoxScoreController do
  use Br.Web, :controller

  def create(conn, params) do
    conn
    |> put_status(:created)
    |> render("created.json")
  end
end