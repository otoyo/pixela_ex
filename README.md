[![CircleCI](https://circleci.com/gh/otoyo/pixela_ex/tree/master.svg?style=svg)](https://circleci.com/gh/otoyo/pixela_ex/tree/master)

# pixela\_ex

[Pixela](https://pixe.la/) API client for Elixir

## Installation

pixela\_ex can be installed by adding `pixela_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:pixela_ex, git: "https://github.com/otoyo/pixela_ex", tag: "0.3.0"}]
end
```

## Usage

Some basic examples:

```elixir
iex> PixelaEx.create_user("a-know", "thisissecret", true, true)
{:ok, %HTTPotion.Response{body: %{"isSuccess" => true, "message" => "Success."},
 headers: %HTTPotion.Headers{hdrs: %{...}},
 status_code: 200}}

iex> PixelaEx.create_graph("a-know", "thisissecret", %{graph_id: "test-graph", name: "graph-name", unit: "commit", type: "int", color: "shibafu"})
%HTTPotion.Response{body: %{"isSuccess" => true, "message" => "Success."},
 headers: %HTTPotion.Headers{hdrs:...}},
 status_code: 200}

iex> PixelaEx.create_pixel("a-know", "thisissecret", "test-graph", %{date: "20181020", quantity: "5"})
%HTTPotion.Response{body: %{"isSuccess" => true, "message" => "Success."},
 headers: %HTTPotion.Headers{hdrs: %{...}},
 status_code: 200}

iex> PixelaEx.increment_pixel("a-know", "thisissecret", "test-graph")
%HTTPotion.Response{body: %{"isSuccess" => true, "message" => "Success."},
 headers: %HTTPotion.Headers{hdrs: %{...}},
 status_code: 200}

iex> PixelaEx.create_webhook("a-know", "thisissecret", %{graph_id: "test-graph", type: "increment"})
%HTTPotion.Response{body: %{"hashString" => "<WebhookHashString>", "isSuccess" => true, "message" => "Success."},
 headers: %HTTPotion.Headers{hdrs: %{...}},
 status_code: 200}
```

## Documetation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc) .

## Contributing

Contributions are welcome ;)
