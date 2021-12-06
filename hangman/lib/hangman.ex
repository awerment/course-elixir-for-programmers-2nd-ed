defmodule Hangman do
  alias Hangman.Runtime.{Application, Server}
  alias Hangman.Type

  @opaque game :: Server.t()
  @type tally :: Type.tally()

  @spec new_game() :: game()
  def new_game() do
    {:ok, pid} = Application.start_game()
    pid
  end

  @spec make_move(game(), String.t()) :: {game(), tally()}
  defdelegate make_move(game, guess), to: Server

  @spec tally(game()) :: tally()
  defdelegate tally(game), to: Server
end
