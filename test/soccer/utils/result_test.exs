defmodule Soccer.ResultTest do
  use Soccer.DataCase

  describe "ok_or_not_found/1" do
    test "returns the value if it is an {:ok, value}" do
      assert {:ok, 1} = Soccer.Result.ok_or_not_found(1)
    end

    test "returns an error if the value is nil" do
      assert {:error, :not_found} = Soccer.Result.ok_or_not_found(nil)
    end
  end
end
