defmodule Exmeal.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:calories, :date, :description]
  @update_params [:calories, :description]

  @derive {Jason.Encoder, only: [:id | @required_params]}

  schema "meals" do
    field :calories, :integer
    field :date, :date, virtual: true
    field :datetime, :utc_datetime
    field :description, :string
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> put_meal_datetime()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, @update_params)
    |> validate_required(@update_params)
  end

  defp put_meal_datetime(
         %Ecto.Changeset{
           valid?: true,
           changes: %{date: date}
         } = changeset
       ) do
    change(changeset, convert_to_datetime(date))
  end

  defp put_meal_datetime(changeset), do: changeset

  def format_meal_date({:ok, %{datetime: datetime} = meal}) do
    %{date: date} = convert_to_date(datetime)
    {:ok, %{meal | date: date}}
  end

  def format_meal_date(result), do: result

  defp convert_to_datetime(date) do
    %{datetime: DateTime.new!(date, ~T[00:00:00])}
  end

  defp convert_to_date(datetime) do
    %{date: Date.new!(datetime.year, datetime.month, datetime.day)}
  end
end
