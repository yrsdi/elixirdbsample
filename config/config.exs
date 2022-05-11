import Config

config :elixirdbsample, Elixirdbsample.Repo,
  database: "mydb",
  username: "root",
  password: "y4d1r054d1",
  hostname: "localhost"

config :elixirdbsample, ecto_repos: [Elixirdbsample.Repo]
