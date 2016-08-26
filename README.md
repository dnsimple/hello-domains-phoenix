# HelloDomains

To start the HelloDomains app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`

At this point the HelloDomains application is installed, but you need to configure a DNSimple OAuth application.

First, you need to create the OAuth application in your DNSimple account. Go to your Account page and click on the Applications tab. Once you are there, click on the Developer applications tab and add a New application. You will need to provide an application name (something like `Hello Domains Phoenix` will work) as well as a homepage URL (any HTTPS URL will do). For the authorization callback, enter `http://localhost:4000/dnsimple/callback`. Once you've created the OAuth application on the DNSimple site, you will see Client ID and Client Secret values on the next page. You will need to copy these two values into your local configuration as described below.

Next, create a file called `config/dev.secret.exs` and add the following, replacing `client_id` and `client_secret` with the values from the OAuth application you added:

```elixir
use Mix.Config

config :hello_domains,
  dnsimple_client_id: "client_id",
  dnsimple_client_secret: "client_secret"
```

Now that the application is configured, start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Testing

To run the tests, run `mix test`.
