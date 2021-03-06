defmodule Backend.Router do
  use Backend.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    # plug CORSPlug, [origin: "*"]
    plug :accepts, ["json", "json-api"]
    # plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/", Backend do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Backend do
    pipe_through :api

    options "/upload", MemeController, :options
    options "/memes", MemeController, :options
    options "/memes/:id", MemeController, :options
    
    get "/sign", MemeController, :sign
    post "/upload", MemeController, :upload
    resources "/memes", MemeController, except: [:new, :edit]
    resources "/hash_tags", HashTagController, except: [:new, :edit]
    resources "/tags", TagController, except: [:new, :edit]
  end
end
