# Elixirdbsample
Sample Elixir Application interact to Mysql Database without schema

**Step by step to create this sample project**

## (1)
```bash
mix new elixirdbsample --sup
```
## (2)
add dependencies to mix.exs

```elixir
defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:myxql, "~> 0.6.0"}
    ]
 end
```
## (3)
```bash
 mix deps.get
```
## (4)
generate db configuration and fill credential information about your database connection

```bash
mix ecto.gen.repo -r Elixirdbsample.Repo
```
## (5)
adding adapter to repo.ex change default postgres to MyXQL and adding some function to interact with database
```elixir
defmodule Elixirdbsample.Repo do
  use Ecto.Repo,
    otp_app: :elixirdbsample,
    adapter: Ecto.Adapters.MyXQL
    
    def get_person() do
      query!("SELECT name FROM person", []) |> into_map()
    end
  
    def get_oneperson(user_id) when is_integer(user_id) do
      query!("SELECT name FROM person WHERE id = ?", [user_id]) |> into_map()
    end
  
    defp into_map(res) do
      Enum.map(res.rows, fn row ->
        Enum.zip(res.columns, row) |> Enum.into(%{})
      end)
    end
end
```
## (6)
Add Repo as Running Worker
```elixir
 children = [
      {Elixirdbsample.Repo, []}
    ]
```
## (7)
add this line code to configuration
```elixir
config :elixirdbsample, ecto_repos: [Elixirdbsample.Repo]
```
## (8)
run this command to create database for Repo
```bash
mix ecto.create
```
## (9)
run this command to generate migration
```bash
mix ecto.gen.migration create_person
```
## (10)
Add this code to migration file
```elixir
  create table(:person) do
      add(:name, :string)
    end
```
## (11)
run this command to start migration
``` bash
mix ecto.migrate 
```
## (12)
create seeds file and add it to start insert value to table
```elixir
Elixirdbsample.Repo.query!("INSERT INTO person SET name = ?", ["Yadi"])
Elixirdbsample.Repo.query!("INSERT INTO person SET name = ?", ["Rosadi"])
```
## (13)
Add this line to elixirdbsample.ex
``` elixir
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
``` 
## (14)
Run this command to lauch repl inside app
```bash
iex -S mix
```
get all person on table
```bash
iex(1)> Elixirdbsample.all_person()
```
get one person on table by id
```bash
iex(2)> Elixirdbsample.one_person(1)
```

