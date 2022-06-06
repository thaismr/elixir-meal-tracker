defmodule ExmealWeb.MealsController do
  use ExmealWeb, :controller

  alias Exmeal.FallbackController
  alias Exmeal.Meal

  def create(conn, params) do
    with {:ok, %Meal{} = meal} <- Exmeal.create_meal(params) do
      conn
      |> put_status(:created)
      |> render("create.json", meal: meal)
    end
  end
end
