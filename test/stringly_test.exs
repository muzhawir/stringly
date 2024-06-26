defmodule StringlyTest do
  use ExUnit.Case, async: true

  doctest Stringly

  describe "Stringly.limit" do
    test "returns the original string when no limit is provided and string is shorter than default limit" do
      assert Stringly.limit("Hello world") === "Hello world"
    end

    test "returns a substring with '...' when the specified limit is less than the string length" do
      assert Stringly.limit("Hello world", 5) === "Hello..."
    end

    test "appends a custom tail when the specified limit is reached" do
      assert Stringly.limit("Hello world", 5, ">>>") === "Hello>>>"
    end
  end

  describe "Stringly.remainder_after" do
    test "return the remainder of a string after the first occurrence of a given value" do
      assert Stringly.remainder_after("Elixir is functional programming language", "is functional") ===
               "programming language"
    end

    test "return entire string if search argument value not exist" do
      assert Stringly.remainder_after("Elixir is functional programming language") ===
               "Elixir is functional programming language"
    end
  end

  describe "Stringly.slug" do
    test "return url friendly slug from the given string" do
      assert Stringly.slug("Post #1: Is Elixir A Functional Programming Language?") ===
               "Post-1-Is-Elixir-A-Functional-Programming-Language"
    end

    test "return downcase url friendly slug from the given string" do
      assert Stringly.slug("Post #1: Is Elixir A Functional Programming Language?", :downcase) ===
               "post-1-is-elixir-a-functional-programming-language"
    end

    test "return upcase url friendly slug from the given string" do
      assert Stringly.slug("Post #1: Is Elixir A Functional Programming Language?", :upcase) ===
               "POST-1-IS-ELIXIR-A-FUNCTIONAL-PROGRAMMING-LANGUAGE"
    end
  end

  describe "Stringly.words" do
    test "returns the original words when no limit no limit is provided and words is shorter than default limit" do
      assert Stringly.words("Elixir is a functional programming language") ===
               "Elixir is a functional programming language"
    end

    test "return a sliced words with '...' when the specified limit is less than words length" do
      assert Stringly.words("Elixir is a functional programming language", 5) === "Elixir is a functional programming..."
    end

    test "appends a custom tail when the specified limit is reached" do
      assert Stringly.words("Elixir is a functional programming language", 5, ">>>") ===
               "Elixir is a functional programming>>>"
    end
  end
end
