defmodule Exmeal.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:calories, :date, :description]

  @derive {Jason.Encoder, only: [:id | @required_params]}

  schema "meals" do
    field :calories, :integer
    field :date, :naive_datetime
    field :description, :string
  end

  def changeset(struct \\ %__MODULE__{}, params)

  def changeset(struct, %{date: %NaiveDateTime{}} = params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end

  def changeset(struct, %{date: %Date{}} = params) do
    params = convert_to_datetime(params)
    changeset(struct, params)
  end

  def changeset(struct, %{date: date} = params) do
    params = %{params | date: Date.from_iso8601!(date)}
    params = convert_to_datetime(params)
    changeset(struct, params)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end

  def format_meal_date({:ok, struct}) do
    case convert_to_date(struct) do
      :error -> {:error, "Error converting date format"}
      struct -> {:ok, struct}
    end
  end

  def format_meal_date(error), do: error

  defp convert_to_datetime(%{date: date} = params) do
    case NaiveDateTime.new(date, ~T[00:00:00]) do
      {:ok, date} -> %{params | date: date}
      _error -> :error
    end
  end

  defp convert_to_datetime(params), do: params

  defp convert_to_date(%{date: date} = params) do
    case Date.new(date.year, date.month, date.day) do
      {:ok, date} -> %{params | date: date}
      _error -> :error
    end
  end
end
