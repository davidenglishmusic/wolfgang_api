defmodule WolfgangApiWeb.Router do
  use WolfgangApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", WolfgangApiWeb do
    pipe_through :api
    resources "/albums", AlbumController, except: [:new, :edit]
  end
end
