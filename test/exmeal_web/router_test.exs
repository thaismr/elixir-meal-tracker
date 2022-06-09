defmodule ExmealWeb.RouterTest do
  use ExmealWeb.ConnCase, async: true

  test "get dashboard path", %{conn: conn} do
    %{status: status} = get(conn, "/dashboard/home")

    assert status == 200
  end
end
