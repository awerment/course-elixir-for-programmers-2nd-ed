defmodule B2Web.Live.Game do
  use B2Web, :live_view

  alias __MODULE__

  def mount(_params, _session, socket) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)

    socket = assign(socket, game: game, tally: tally)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="game-holder" phx-window-keyup="make_move">
      <.live_component module={Game.Figure} id="1" tally={@tally} />
      <.live_component module={Game.Alphabet} id="2" tally={@tally} />
      <.live_component module={Game.WordSoFar} id="3" tally={@tally} />
    </div>
    """
  end

  @valid_keys ?a..?z |> Enum.map(&<<&1::utf8>>)
  def handle_event("make_move", %{"key" => key}, socket) when key in @valid_keys do
    tally = Hangman.make_move(socket.assigns.game, key)
    socket = assign(socket, tally: tally)
    {:noreply, socket}
  end

  def handle_event("make_move", _, socket), do: {:noreply, socket}
end
