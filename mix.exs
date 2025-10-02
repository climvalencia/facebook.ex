Code.ensure_loaded?(Hex) and Hex.start()

defmodule Facebook.Mixfile do
  use Mix.Project

  @support_native_json Version.match?(System.version(), ">= 1.18.0")

  def project do
    [
      app: :facebook,
      version: "0.24.0",
      elixir: "~> 1.0",
      description: description(),
      package: package(),
      deps: deps(),
      source_url: "https://github.com/mweibel/facebook.ex"
    ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: {Facebook, []},
      applications: applications(@support_native_json),
      env: [
        env: :dev,
        graph_url: "https://graph.facebook.com",
        graph_video_url: "https://graph-video.facebook.com",
        app_secret: nil,
        app_id: nil,
        app_access_token: nil,
        request_conn_timeout: nil,
        request_recv_timeout: nil
      ]
    ]
  end

  defp applications(true), do: [:httpoison, :logger]
  defp applications(_), do: [:httpoison, :json, :logger]

  defp description do
    """
    Facebook Graph API Wrapper written in Elixir.
    Please note, this is very much a work in progress. Feel free to contribute using pull requests.
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/mweibel/facebook.ex"
      },
      maintainers: [
        "mweibel",
        "jovannypcg"
      ]
    ]
  end

  defp deps do
    deps_json(@support_native_json) ++ [
      {:httpoison, "~> 1.4"},
      {:mock, "~> 0.3.2", only: :test},
      {:mix_test_watch, "~> 0.9", only: :dev, runtime: false},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.19.2", only: :dev}
    ]
  end

  defp deps_json(true), do: []
  defp deps_json(_), do: [{:json, ">= 1.2.5"}]
end
