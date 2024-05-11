defmodule Stringly.Slug do
  @moduledoc false

  @spec normalize_title(String.t(), String.t()) :: String.t()
  @doc """
  Normalizes the title based on the specified language by converting characters to their normalized form (NFD).
  """
  def normalize_title(title, ""), do: title

  def normalize_title(title, _language),
    do: title |> String.to_charlist() |> :unicode.characters_to_nfd_binary() |> to_string()

  @spec replace_separator(String.t(), String.t()) :: String.t()
  @doc """
  Replaces all instances of underscores or dashes (depending on the specified separator) in the title with the specified separator.
  """
  def replace_separator(title, separator),
    do: Regex.replace(~r/[#{Regex.escape((separator == "-" && "_") || "-")}]+/u, title, separator)

  @spec replace_dictionary_words(String.t(), map(), String.t()) :: String.t()
  @doc """
  Replaces each key in the dictionary found in the title with its corresponding value, enclosed by the specified separator.
  """
  def replace_dictionary_words(title, dictionary, separator) do
    Enum.reduce(dictionary, title, fn {key, value}, acc ->
      String.replace(acc, key, "#{separator}#{value}#{separator}")
    end)
  end

  @spec remove_invalid_characters(String.t(), String.t()) :: String.t()
  @doc """
  Removes all characters from the title that are not letters, numbers, separators, or whitespace.
  """
  def remove_invalid_characters(title, separator),
    do: Regex.replace(~r/[^#{Regex.escape(separator)}\p{L}\p{N}\s]/u, title, "")

  @spec compress_separators(String.t(), String.t()) :: String.t()
  @doc """
  Compresses consecutive separators and whitespace in the title into a single instance of the specified separator.
  """
  def compress_separators(title, separator), do: Regex.replace(~r/[#{Regex.escape(separator)}\s]+/u, title, separator)

  @spec handle_case(String.t(), :default | :downcase | :upcase) :: String.t()
  @doc """
  Handles the casing of the title according to the specified case option.
  """
  def handle_case(title, :default), do: title
  def handle_case(title, :downcase), do: String.downcase(title)
  def handle_case(title, :upcase), do: String.upcase(title)
end
