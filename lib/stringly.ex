defmodule Stringly do
  @moduledoc """
  Stringly is a wide variety of string manipulation functions.
  """
  @spec remainder_after(String.t(), String.t()) :: String.t()
  @doc """
  Returns everything after the given value in a string.

  The entire string will be returned if the value does not exist within the string.

  ## Examples
      iex> Stringly.remainder_after("Elixir is functional programming language", "is functional")
      "programming language"

      iex> Stringly.remainder_after("Elixir is functional programming language")
      "Elixir is functional programming language"
  """
  def remainder_after(subject), do: subject

  def remainder_after(subject, ""), do: subject

  def remainder_after(subject, search) when search != "" do
    case String.split(subject, search, parts: 2, trim: true) do
      [_, remainder | _] -> String.trim(remainder)
      _ -> ""
    end
  end

  @spec limit(String.t(), pos_integer(), String.t()) :: String.t()
  @spec limit(binary(), pos_integer()) :: binary()
  @doc """
  Limits the number of strings.

  If the number of strings exceeds the specified limit, this function will truncate the string and appends a truncation string.

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
  Limits the number of words in a given string.

  If the number of words exceeds the specified limit, the function truncates the words and appends a truncation string.

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
