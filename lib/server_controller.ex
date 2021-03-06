defmodule GPanel.ServerController do
  use GenStateMachine

  @moduledoc """
  States:
  idle -> starting -> running -> stopping -> idle
  """

  # API
  def start_link(_opts) do
    GenStateMachine.start_link(__MODULE__, {:idle, nil}, name: __MODULE__)
  end

  def start_server do
    GenStateMachine.cast(__MODULE__, :start_server)
  end

  def stop_server do
    GenStateMachine.cast(__MODULE__, :stop_server)
  end

  def get_status do
    case Process.whereis(__MODULE__) do
      nil ->
        {:not_started, nil}
      _pid ->
        GenStateMachine.call(__MODULE__, :get_status)
    end
  end

  # Callbacks
  def handle_event({:call, from}, :get_status, state, data) do
    {:keep_state_and_data, [{:reply, from, status_to_json(state, data)}]}
  end

  def handle_event(:cast, :start_server, :idle, data) do
    GenStateMachine.cast(__MODULE__, :process_start)
    {:next_state, :starting, data}
  end

  def handle_event(:cast, :stop_server, :running, _data) do
    GenStateMachine.cast(__MODULE__, :process_stop)
    {:next_state, :stopping, nil}
  end

  def handle_event(:cast, :process_start, :starting, _data) do
    :timer.sleep(4000)
    {:next_state, :running, "1.2.3.4"}
  end

  def handle_event(:cast, :process_stop, :stopping, _data) do
    :timer.sleep(4000)
    {:next_state, :idle, nil}
  end

  def handle_event(:cast, _cmd, _state, _data) do
    :keep_state_and_data
  end

  def test() do
    GPanel.ServerController.start_link([])
    {:idle, nil} = GPanel.ServerController.get_status()

    GPanel.ServerController.start_server()
    {:starting, nil} = GPanel.ServerController.get_status()

    :timer.sleep(4100)
    {:running, "1.2.3.4"} = GPanel.ServerController.get_status()

    GPanel.ServerController.stop_server()
    {:stopping, nil} = GPanel.ServerController.get_status()

    :timer.sleep(4100)
    {:idle, nil} = GPanel.ServerController.get_status()
  end

  defp start_container do
    path = Application.get_env(:gpanel, :script_dir)

    # TODO: add secure check for script
    {res, _} = System.cmd(path <> "/scripts/start_server.sh", [])

    res
    |> String.split("\n")
    |> Enum.at(0)
  end

  defp stop_container do
    path = Application.get_env(:gpanel, :script_dir)

    # TODO: add secure check for script
    {res, _} = System.cmd(path <> "/scripts/stop_server.sh", [])

    res
    |> String.split("\n")
    |> Enum.at(0)
  end

  defp status_to_json(state, data) do
    case {state, data} do
      {:running, ip} ->
        %{status: "up", ip: ip}
      {:starting, _} ->
        %{status: "starting", ip: ""}
      {:stopping, _} ->
        %{status: "stopping", ip: ""}
      {:idle, _} ->
        %{status: "not running", ip: ""}
    end
  end
end
