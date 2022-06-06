defmodule Exmeal.Meals.Create do
  alias Exmeal.{Meal, Repo}
  alias Exmeal.FallbackController

  def call(%{date: date} = params) do
   params
    |> Meal.changeset()
    |> Repo.insert()
    |> Meal.get_changeset()
  end
end
