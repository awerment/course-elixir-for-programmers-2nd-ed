defmodule TextClient do
  alias TextClient.Runtime.RemoteHangman
  @spec start() :: :ok
  def start() do
    RemoteHangman.connect()
    |> TextClient.Impl.Player.start()
    |> RemoteHangman.disconnect()
  end
end
