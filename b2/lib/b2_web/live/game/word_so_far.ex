defmodule B2Web.Live.Game.WordSoFar do
  use Phoenix.LiveComponent

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
      <div class="word-so-far">
        <div class="game-state">
          <%= state_name(@tally.game_state) %>
        </div>
        <div class="letters">
          <%= for ch <- @tally.letters do %>
            <div class={"one-letter " <> class_of(ch, @tally)}>
              <%= ch %>
            </div>
          <% end %>
        </div>
      </div>
    """
  end

  @states %{
    initializing: "Type or click on your first guess.",
    good_guess: "Good guess!",
    bad_guess: "That's not in the word.",
    won: "You won!",
    lost: "Sorry, you lost.",
    already_used: "You already picked that letter."
  }
  defp state_name(state) do
    @states[state] || "Unknown state"
  end

  defp class_of("_", _), do: ""

  defp class_of(letter, tally) do
    case {Enum.member?(tally.letters, letter), Enum.member?(tally.used, letter)} do
      {true, true} -> "correct"
      {true, false} -> "wrong"
      _ -> ""
    end
  end
end
