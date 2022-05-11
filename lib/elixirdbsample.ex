defmodule Elixirdbsample do
  alias Elixirdbsample.Repo
  @moduledoc """
  Documentation for `Elixirdbsample`.
  """
  def all_person() do
    Repo.get_person()
    |> Enum.map(fn %{"name" => name} -> "Hello, #{name}" end)
    |> Enum.each(&IO.puts(&1))
  end

  def one_person(user_id) do
    Repo.get_oneperson(user_id)
    |> Enum.map(fn %{"name" => name} -> "Hello, #{name}" end)
    |> Enum.each(&IO.puts(&1))
  end
end
