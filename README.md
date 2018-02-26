# Identicon

Elixir identicon, generates a unique image pattern from text

## Installation

The package can be installed
by adding `identicon` and `egd` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:identicons, "~> 0.1.0"},
    {:egd, github: "erlang/egd"}
  ]
end
```
Then run the command `mix deps.get`

Documentation is in docs file or [Docs](https://hexdocs.pm/identicons/Identicon.html)

## Example

The folder `generated_identicon/` must exist

```elixir
  iex>Identicon.main "test", 250, "generated_identicon/"
  :ok
```

# Identicon
