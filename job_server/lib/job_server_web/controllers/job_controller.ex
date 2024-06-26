defmodule JobServerWeb.JobController do
  use JobServerWeb, :controller

  def create(conn, %{"tasks" => tasks}) do
    case topsort(tasks) do
      {:ok, sorted_tasks} ->
        case conn |> get_req_header("accept") |> List.first() do
          "text/plain" ->
            script =
              Enum.map(sorted_tasks, fn %{name: _name, command: command} ->
                command
              end)
              |> Enum.join("\n")

            conn
            |> put_resp_content_type("text/plain")
            |> send_resp(200, "#!/usr/bin/env bash\n#{script}")

          _ ->
            conn
            |> put_resp_content_type("application/json")
            |> json(%{"tasks" => sorted_tasks})
        end

      {:error, :cycle} ->
        conn
        |> send_resp(400, "Bad Request: Tasks do not form a valid DAG")
    end
  end

  defp topsort(tasks) do
    # add vertices
    dag =
      Enum.reduce(tasks, DAG.new(), fn %{"name" => n}, {:ok, acc} ->
        DAG.add_vertex(acc, n)
      end)

    # add edges
    dag2 =
      Enum.reduce(tasks, dag, fn
        %{"name" => n, "requires" => req}, acc ->
          Enum.reduce(req, acc, fn
            r, {:ok, acc2} -> DAG.add_edge(acc2, n, r)
            _r, error -> error
          end)

        _, acc ->
          acc
      end)

    # topology sort
    case dag2 do
      {:error, :cycle} ->
        {:error, :cycle}

      {:ok, dag3} ->
        result =
          DAG.topsort(dag3)
          |> Enum.map(fn name ->
            %{name: name, command: get_command(tasks, name)}
          end)

        {:ok, result}
    end
  end

  defp get_command(tasks, name) do
    %{"command" => c} =
      Enum.find(
        tasks,
        fn %{"name" => n} -> n == name end
      )

    c
  end
end
