defmodule Ties.Router do
  use Phoenix.Router
  use Phoenix.Router.Socket, mount: "/ws"
  channel "games", Ties.GamesChannel
  get "/", Ties.PageController, :index, as: :pages
end
