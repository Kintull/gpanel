defmodule GPanelWeb.PageController do
  use GPanelWeb, :controller
  alias GPanel.ServerController


  def index(conn, _params) do
    render(conn, "index.html")
  end

  def start_server(conn, _) do
    ServerController.start_server()
    status = ServerController.get_status()
    json(conn, wrap_response(status))
  end

  def stop_server(conn, _) do
    ServerController.stop_server()
    status = ServerController.get_status()
    json(conn, wrap_response(status))
  end

  def wrap_response(data) do
    %{"body" => data}
  end
end
