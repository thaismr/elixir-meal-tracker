defmodule Exmeal.Factory do
  use ExMachina

  def meal_params_factory do
    %{
      description: "Roasted beef",
      date: "2022-05-02",
      calories: "200"
    }
  end
end
