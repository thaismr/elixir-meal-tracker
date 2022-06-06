defmodule Exmeal.Meals.Create do
  alias Exmeal.{Error, Meal, Repo}

  def call(%{date: date} = params) do
   params
    |> Meal.changeset()
    |> Repo.insert()
    |> Meal.format_meal_date()
    |> handle_response()
  end

  defp handle_response({:ok, %Meal{}} = result) do
    result
  end

  defp handle_response({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
