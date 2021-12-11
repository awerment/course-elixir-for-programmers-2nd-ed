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
    <div class="game-holder">
      <%= live_component(Game.Figure, tally: @tally, id: 1) %>
      <%= live_component(Game.Alphabet, tally: @tally, id: 2) %>
      <%= live_component(Game.WordSoFar, tally: @tally, id: 3) %>
    </div>
    """
  end
end
