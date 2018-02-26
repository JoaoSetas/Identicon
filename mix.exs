defmodule Identicon.MixProject do
  use Mix.Project

  def project do
    [
      app: :identicon,
      version: "0.1.1",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Identicons",
      source_url: "https://github.com/JoaoSetas/Identicon"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description() do
    "Identicon is a image with a unique pattern to identify a user"
  end


  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.14"}, 
      {:egd, github: "erlang/egd"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp package() do
    [
      maintainers: ["João Setas"],
      licenses: ["Ex_doc 0.14"],
      links: %{"GitHub" => "https://github.com/JoaoSetas/Identicon"}
    ]
  end
end
