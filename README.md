[![CircleCI](https://circleci.com/gh/otoyo/pixela_ex/tree/master.svg?style=svg)](https://circleci.com/gh/otoyo/pixela_ex/tree/master)

# pixela\_ex

[Pixela](https://pixe.la/) API client for Elixir

## Installation

pixela\_ex can be installed by adding `pixela_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:pixela_ex, git: "https://github.com/otoyo/pixela_ex", tag: "1.0.0"}]
end
```

## Usage

Some basic examples:

```elixir
iex> PixelaEx.create_user("a-know", "thisissecret", true, true)
{:ok, %HTTPotion.Response{body: %{"isSuccess" => true, "message" => "Success."},
 headers: %HTTPotion.Headers{hdrs: %{...}},
 status_code: 200}}

iex> PixelaEx.create_graph("a-know", "thisissecret", "test-graph", "graph-name", "commit", "int", "shibafu")
{:ok, %HTTPotion.Response{body: %{"isSuccess" => true, "message" => "Success."},
 headers: %HTTPotion.Headers{hdrs: %{...}},
 status_code: 200}}

iex> PixelaEx.create_pixel("a-know", "thisissecret", "test-graph", "20181020", "5")
{:ok, %HTTPotion.Response{body: %{"isSuccess" => true, "message" => "Success."},
 headers: %HTTPotion.Headers{hdrs: %{...}},
 status_code: 200}}

iex> PixelaEx.increment_pixel("a-know", "thisissecret", "test-graph")
{:ok, %HTTPotion.Response{body: %{"isSuccess" => true, "message" => "Success."},
 headers: %HTTPotion.Headers{hdrs: %{...}},
 status_code: 200}}

iex> PixelaEx.create_webhook("a-know", "thisissecret", "test-graph", "increment")
{:ok %HTTPotion.Response{body: %{"hashString" => "<WebhookHashString>", "isSuccess" => true, "message" => "Success."},
 headers: %HTTPotion.Headers{hdrs: %{...}},
 status_code: 200}}
```

## Documetation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc) .

## Contributing

Contributions are welcome ;)
