defmodule Ties.Router do
  use Phoenix.Router

  get "/", Ties.PageController, :index, as: :pages

end
