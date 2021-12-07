defmodule Hangman.Runtime.Server do
  use GenServer, restart: :transient
  alias Hangman.Impl.Game

  @type t :: pid()

  # client

  def start_link(_args) do
    GenServer.start_link(__MODULE__, nil)
  end

  def make_move(pid, guess) do
    GenServer.call(pid, {:make_move, guess})
  end

  def tally(pid) do
    GenServer.call(pid, {:tally})
  end

  # server

  def init(_args) do
    {:ok, Game.new_game()}
  end

  def handle_call({:make_move, guess}, _from, game) do
    {updated_game, tally} = Game.make_move(game, guess)
    {:reply, tally, updated_game}
  end

  def handle_call({:tally}, _from, game) do
    {:reply, Game.tally(game), game}
  end
end
