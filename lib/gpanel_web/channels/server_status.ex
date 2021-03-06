defmodule GPanelWeb.ServerStatus do
  use Phoenix.Channel
  alias GPanel.ServerController

  def join("server:status", _msg, socket) do
    send(self(), :send_feed)
    :timer.send_interval(2000, self(), :send_feed)
    {:ok, socket}
  end

  def handle_in("get_status", _, socket) do
    status = ServerController.get_status()
    broadcast!(socket, "feed", %{"body" => status})
    {:noreply, socket}
  end

  def handle_info(:send_feed, socket) do
    status = ServerController.get_status()
    broadcast!(socket, "feed", %{"body" => status})
    {:noreply, socket}
  end
end