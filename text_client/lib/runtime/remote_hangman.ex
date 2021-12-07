defmodule TextClient.Runtime.RemoteHangman do
  @remote_server :hangman@awer

  def connect() do
    :rpc.call(@remote_server, Hangman, :new_game, [])
  end

  def disconnect(game) do
    :rpc.call(@remote_server, Hangman, :stop_game, [game])
  end
end
