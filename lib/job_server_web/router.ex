defmodule JobServerWeb.Router do
  use JobServerWeb, :router

  pipeline :api do
    plug :accepts, ["json", "text"]
  end

  scope "/api", JobServerWeb do
    pipe_through :api
    post "/job", JobController, :create
  end

end

