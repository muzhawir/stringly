defmodule Stringly do
  @moduledoc """
  Stringly is an Elixir package packed with a wide range of string manipulation functions.
  It boosts Elixir's native String module with some extra handy tools.
  """
  @deprecated "Use Stringly.truncate_string/3 instead."
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
  @deprecated "Use Stringly.substring_after/2 instead."
  def remainder_after(subject, search) when search != "" do
    case String.split(subject, search, parts: 2, trim: true) do
      [_, remainder | _] -> String.trim(remainder)
      _ -> ""
    end
  end

  def remainder_after(subject, ""), do: subject

  def remainder_after(subject), do: subject

  @spec slug(String.t(), :default | :downcase | :upcase, String.t(), String.t(), map()) :: String.t()
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
  @deprecated "Use Stringly.generate_slug/3 instead."
  def slug(title, case_option \\ :default, separator \\ "-", language \\ "en", dictionary \\ %{"@" => "at"}) do
    import Stringly.Slug

    title
    |> normalize_title(language)
    |> replace_separator(separator)
    |> replace_dictionary_word(dictionary, separator)
    |> remove_invalid_character(separator)
    |> compress_separator(separator)
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
  @deprecated "Use Stringly.truncate_word/3 instead."
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
