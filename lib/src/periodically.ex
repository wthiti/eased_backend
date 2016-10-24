defmodule EasedBackend.Periodically do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    schedule_work()

    update_teacher_possibility()

    {:noreply, state}
  end

  defp update_teacher_possibility() do
    # Query requests with "Created" status

    # Match requests with teachers and calculate the score
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 1 * 60 * 60 * 1000) # In 1 hour
  end
end
