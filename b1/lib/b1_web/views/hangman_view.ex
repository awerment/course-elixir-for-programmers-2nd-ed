defmodule B1Web.HangmanView do
  use B1Web, :view

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

  def figure_for(0) do
    ~S"""
      +---+
      |   |
      O   |
     /|\  |
     / \  |
          |
    =========
    """
  end

  def figure_for(1) do
    ~S"""
      +---+
      |   |
      O   |
     /|\  |
     /    |
          |
    =========
    """
  end

  def figure_for(2) do
    ~S"""
      +---+
      |   |
      O   |
     /|\  |
          |
          |
    =========
    """
  end

  def figure_for(3) do
    ~S"""
      +---+
      |   |
      O   |
     /|   |
          |
          |
    =========
    """
  end

  def figure_for(4) do
    ~S"""
      +---+
      |   |
      O   |
      |   |
          |
          |
    =========
    """
  end

  def figure_for(5) do
    ~S"""
      +---+
      |   |
      O   |
          |
          |
          |
    =========
    """
  end

  def figure_for(6) do
    ~S"""
      +---+
      |   |
          |
          |
          |
          |
    =========
    """
  end

  def figure_for(7) do
    ~S"""
      +---+
          |
          |
          |
          |
          |
    =========
    """
  end
end
