defmodule Siga.BucketServer do
  use Agent

  def start_link(initial_value \\ %{}) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  @type key :: String.t()

  @spec get(key) :: any()
  def get(key) do
    Agent.get(__MODULE__, &Map.get(&1, key))
  end

  @type value :: any()
  @spec put(key, value) :: atom()
  def put(key, value) do
    Agent.update(__MODULE__, &Map.put(&1, key, value))
  end

  @spec delete(key) :: atom()
  def delete(key) do
    Agent.update(__MODULE__, &Map.delete(&1, key))
  end

  def uptime(format) do
    init_time = get("init_time")
    atom_format = String.to_atom(format)
    current_time = Application.get_env(:siga, :timezone) |> Timex.now()

    case Timex.diff(current_time, init_time, atom_format) do
      {:error, {_, invalid_format}} ->
        {:bad_request, "invalid format '#{invalid_format}'"}

      timestamp ->
        {:ok, timestamp}
    end
  end
end
