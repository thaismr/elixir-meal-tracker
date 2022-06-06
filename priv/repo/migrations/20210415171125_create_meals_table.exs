defmodule Exmeal.Repo.Migrations.CreateMealsTable do
  use Ecto.Migration

  def change do
    create table :meals do
      add :calories, :integer
      add :date, :naive_datetime
      add :description, :string
    end
  end
end
