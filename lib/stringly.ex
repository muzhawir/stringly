defmodule Stringly do
  @moduledoc """
  Stringly is a wide variety of string manipulation functions.
  """

  @spec limit(String.t(), pos_integer(), String.t()) :: String.t()
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
  def remainder_after(subject, search) when search != "" do
    case String.split(subject, search, parts: 2, trim: true) do
      [_, remainder | _] -> String.trim(remainder)
      _ -> ""
    end
  end

  def remainder_after(subject, ""), do: subject

  def remainder_after(subject), do: subject

  @doc """
  Generates a URL friendly slug from the given string.

  ## Examples
      iex> Stringly.slug("Post #1: Is Elixir A Functional Programming Language?")
      "Post-1-Is-Elixir-A-Functional-Programming-Language"

      iex> Stringly.slug("Post #1: Is Elixir A Functional Programming Language?", :downcase)
      "post-1-is-elixir-a-functional-programming-language"

      iex> Stringly.slug("Post #1: Is Elixir A Functional Programming Language?", :upcase)
      "POST-1-IS-ELIXIR-A-FUNCTIONAL-PROGRAMMING-LANGUAGE"
  """
  def slug(title, case_option \\ :default, separator \\ "-", language \\ "en", dictionary \\ %{"@" => "at"}) do
    import Stringly.Slug

    title
    |> normalize_title(language)
    |> replace_separator(separator)
    |> replace_dictionary_words(dictionary, separator)
    |> remove_invalid_characters(separator)
    |> compress_separators(separator)
    |> String.trim(separator)
    |> handle_case(case_option)
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
