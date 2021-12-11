defmodule B1Web.HangmanView do
  use B1Web, :view

  alias B1Web.HangmanView.Helpers.FigureFor

  defdelegate figure_for(state), to: FigureFor

  @state_fields %{
    initializing: {"initializing", "Guess the word, a letter at a time."},
    good_guess: {"good-guess", "Good guess!"},
    bad_guess: {"bad-guess", "Sorry, that's a bad guess."},
    won: {"won", "You won!"},
    lost: {"lost", "Sorry, you lost."},
    already_used: {"already-used", "You already used that letter"}
  }
  def move_state(state) do
    {class, msg} = @state_fields[state]

    "<div class='status #{class}'>#{msg}</div>"
    |> raw()
  end

  def continue_or_try_again(conn, state) when state in [:won, :lost] do
    button("Try again", to: Routes.hangman_path(conn, :new))
  end

  def continue_or_try_again(conn, _state) do
    form_for(conn, Routes.hangman_path(conn, :update), [as: "make_move", method: :put], fn f ->
      [
        text_input(f, :guess),
        submit("Make next guess")
      ]
    end)
  end
end
