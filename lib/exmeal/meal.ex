defmodule Exmeal.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:calories, :date, :description]

  schema "meals" do
    field :calories, :integer
    field :date, :naive_datetime
    field :description, :string
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    params = convert_to_datetime(params)

    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end

  def get_changeset({:ok, struct}) do
    case convert_to_date(struct) do
      :error -> {:error, "Error converting date format"}
      struct -> {:ok, struct}
    end
  end

  def get_changeset(error), do: error

  defp convert_to_datetime(%{date: date} = params) do
    case DateTime.new(date, ~T[00:00:00], "Etc/UTC") do
      {:ok, date} -> %{params | date: date}
      error -> :error
    end
  end

  defp convert_to_date(%{date: date} = params) do
    case Date.new(date.year, date.month, date.day) do
      {:ok, date} -> %{params | date: date}
      error -> :error
    end
  end
end
