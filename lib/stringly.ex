defmodule Stringly do
  @moduledoc """
  Stringly is a wide variety of string manipulation functions.
  """

  @spec limit(String.t(), pos_integer(), String.t()) :: String.t()
  @doc """
  Limit the number of characters in a string.

  ## Examples
      iex> Stringly.limit("Hello world")
      "Hello world"

      iex> Stringly.limit("Hello world", 5)
      "Hello..."

      iex> Stringly.limit("Hello world", 5, ">>>")
      "Hello>>>"
  """
  def limit(string, limit \\ 100, tail \\ "...") do
    if String.length(string) <= limit do
      string
    else
      String.slice(string, 0, limit) <> tail
    end
  end

  @spec words(String.t(), pos_integer(), String.t()) :: String.t()
  @doc """
  Limits the number of words in a given string. If the number of words exceeds the specified limit,
  the function truncates the string and appends an ellipsis or a custom truncation string.

  ## Examples
      iex> Stringly.words("Elixir is a functional programming language")
      "Elixir is a functional programming language"

      iex> Stringly.words("Elixir is a functional programming language", 5)
      "Elixir is a functional programming..."

      iex> Stringly.words("Elixir is a functional programming language", 5, ">>>")
      "Elixir is a functional programming>>>"
  """
  def words(string, limit \\ 100, tail \\ "...") do
    word_list = String.split(string)

    result = word_list |> Enum.take(limit) |> Enum.join(" ")

    if Enum.count(word_list) <= limit do
      result
    else
      result <> tail
    end
  end
end
