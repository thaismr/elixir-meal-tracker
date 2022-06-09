defmodule Exmeal.MealTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Ecto.Changeset
  alias Exmeal.Meal

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{description: "Batata", date: "2001-05-02", calories: "20"}

      response = Meal.changeset(params)

      assert %Changeset{
               changes: %{description: "Batata", date: ~D[2001-05-02], calories: 20},
               valid?: true
             } = response
    end

    test "when invalid date param is given, returns an error" do
      params = build(:meal_params, %{date: "2022"})

      response = Meal.changeset(params)

      expected_response = %{
        date: ["is invalid"]
      }

      assert errors_on(response) == expected_response
    end
  end

  describe "format_meal_date/1" do
    test "when given a successful meal with datetime, fills date from converted format" do
      params = build(:meal_params, %{datetime: ~U[2022-06-14 00:00:00Z]})

      params = {:ok, params}

      response = Meal.format_meal_date(params)

      assert {:ok, %{date: ~D[2022-06-14]}} = response
    end

    test "when given a succesful meal without datetime, pass it forward" do
      params = {:ok, build(:meal_params)}

      response = Meal.format_meal_date(params)

      assert response == params
    end
  end
end
