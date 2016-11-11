defmodule Br.Router do
  use Br.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", Br do
    pipe_through :api
    
    resources "/box_scores", BoxScoreController, only: [:create]
  end
end
