defmodule Mix.Tasks.RunRover do
  @moduledoc "The hello mix task: `mix help hello`"
  use Mix.Task

  def run(_) do
    Mix.Shell.cmd("rover dev --supergraph-config ./router/supergraph-config.yaml \
   --router-config ./router/router-config.yaml", [quiet: true], &IO.puts/1)
  end
end
