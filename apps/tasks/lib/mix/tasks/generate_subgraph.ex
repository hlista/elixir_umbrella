defmodule Mix.Tasks.GenerateSubgraph do
  @moduledoc "The hello mix task: `mix help hello`"
  use Mix.Task

  def run([app]) do
    Mix.Shell.cmd("mix absinthe.federation.schema.sdl --schema #{String.capitalize(app)}Web.Schema", [cd: "./apps/#{app}"], &IO.puts/1)
  end

  def run(_) do
    IO.inspect("Pass in app name from root of umbrella")
  end
end
