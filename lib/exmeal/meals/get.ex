defmodule Exmeal.Meals.Get do
  alias Ecto.UUID
  alias Exmeal.{Error, Meal, Repo}

  def by_id(id) do
    case UUID.cast(id) do
      :error -> {:error, %{status: :bad_request, result: "Invalid id format!"}}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Meal, uuid) do
      nil -> {:error, Error.build_meal_not_found_error()}
      meal -> {:ok, meal} |> Meal.format_meal_date()
    end
  end
end
