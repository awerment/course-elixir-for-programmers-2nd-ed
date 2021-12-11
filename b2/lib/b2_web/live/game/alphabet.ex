defmodule B2Web.Live.Game.Alphabet do
  use Phoenix.LiveComponent

  def mount(socket) do
    letters = ?a..?z |> Enum.map(&<<&1::utf8>>)
    {:ok, assign(socket, letters: letters)}
  end

  def render(assigns) do
    ~H"""
      <div class="alphabet">
        <%= for letter <- @letters do %>
          <div phx-click="make_move"
               phx-value-key={letter}
               class={"one-letter " <> class_of(letter, @tally)}>
            <%= letter %>
          </div>
        <% end %>
      </div>
    """
  end

  defp class_of(letter, tally) do
    case {Enum.member?(tally.letters, letter), Enum.member?(tally.used, letter)} do
      {true, true} -> "correct"
      {false, true} -> "wrong"
      _ -> ""
    end
  end
end
