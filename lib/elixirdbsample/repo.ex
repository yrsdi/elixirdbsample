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
