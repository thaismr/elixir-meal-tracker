defmodule Exmeal.Meals.Delete do
  alias Ecto.UUID
  alias Exmeal.{Error, Meal, Repo}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, %{status: :bad_request, result: "Invalid id format!"}}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(id) do
    case Repo.get(Meal, id) do
      nil -> {:error, Error.build_meal_not_found_error()}
      meal -> Repo.delete(meal) |> Meal.format_meal_date()
    end
  end
end
