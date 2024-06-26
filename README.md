# JobServer

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

# How to use

Start web server with:

```
mix phx.server
```

From terminal run:
```bash
> ./json.sh 
{"tasks":[{"command":"touch /tmp/file1","name":"task-1"},{"command":"echo 'Hello World!' > /tmp/file1","name":"task-3"},{"command":"cat /tmp/file1","name":"task-2"},{"command":"rm /tmp/file1","name":"task-4"}]}
```

or

```bash
> ./bash.sh 
#!/usr/bin/env bash
touch /tmp/file1
echo 'Hello World!' > /tmp/file1
cat /tmp/file1
rm /tmp/file1
```
