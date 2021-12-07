defmodule Hangman.Runtime.Application do
  use Application
  alias Hangman.Runtime.Server

  @super_name GameStarter
  def start(_type, _args) do
    supervisor_spec = [
      {DynamicSupervisor, strategy: :one_for_one, name: @super_name}
    ]

    Supervisor.start_link(supervisor_spec, strategy: :one_for_one)
  end

  def start_game() do
    DynamicSupervisor.start_child(@super_name, {Server, nil})
  end

  def stop_game(pid) do
    DynamicSupervisor.terminate_child(@super_name, pid)
  end
end
