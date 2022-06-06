defmodule Exmeal.Meals.Create do
  alias Exmeal.{Error, Meal, Repo}

  def call(%{date: date} = params) do
   params
    |> Meal.changeset()
    |> Repo.insert()
    |> Meal.get_changeset()
    |> handle_response()
  end

  defp handle_response({:ok, %Meal{}} = result), do: result

  defp handle_response({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
