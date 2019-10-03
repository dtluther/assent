defmodule Assent.Strategy.Basecamp do
  @moduledoc """
  Basecamp OAuth 2.0 strategy.

  `basecamp_accounts` field is included in user parameters and can be
  used to limit access to users belonging to a particular account.

  ## Usage

      config = [
        client_id: "REPLACE_WITH_CLIENT_ID",
        client_secret: "REPLACE_WITH_CLIENT_SECRET"
      ]
  """
  use Assent.Strategy.OAuth2.Base

  @impl true
  def default_config(_config) do
    [
      site: "https://launchpad.37signals.com",
      authorize_url: "/authorization/new",
      token_url: "/authorization/token",
      user_url: "/authorization.json",
      authorization_params: [type: "web_server"],
      auth_method: :client_secret_post
    ]
  end

  @impl true
  def normalize(_config, user) do
    {:ok, %{
      "sub"         => user["identity"]["id"],
      "name"        => "#{user["identity"]["first_name"]} #{user["identity"]["last_name"]}",
      "given_name"  => user["identity"]["first_name"],
      "family_name" => user["identity"]["last_name"],
      "email"       => user["identity"]["email_address"]
    },
    %{
      "basecamp_accounts" => user["accounts"]
    }}
  end
end
