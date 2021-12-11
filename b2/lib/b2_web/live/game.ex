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
      <%= live_component(Game.Figure, tally: @tally, id: 1) %>
      <%= live_component(Game.Alphabet, tally: @tally, id: 2) %>
      <%= live_component(Game.WordSoFar, tally: @tally, id: 3) %>
    </div>
    """
  end

  @valid_keys ?a..?z |> Enum.to_list() |> List.to_string() |> String.codepoints()
  def handle_event("make_move", %{"key" => key}, socket) when key in @valid_keys do
    tally = Hangman.make_move(socket.assigns.game, key)
    socket = assign(socket, tally: tally)
    {:noreply, socket}
  end

  def handle_event("make_move", _, socket), do: {:noreply, socket}
end
