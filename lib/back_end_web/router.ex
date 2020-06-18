defmodule BackEndWeb.Router do
  use BackEndWeb, :router


  alias BackEndWeb.Plug.Auth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :app do
    plug(Auth)
  end

  scope "/api", BackEndWeb do
    pipe_through :api
    
    scope "/users" do
      get("/get_user", AuthController, :get_user)
      post("/update", AuthController, :update)
      post("/sign_in", AuthController, :sign_in)
      post("/sign_up", AuthController, :create)
      post("/me", AuthController, :auth_account)
    end

    resources "/company", CompanyController, only: [:index, :show]
    post "update_company/:id", CompanyController, :update

    resources "/job_post", JobPostController, except: [:new, :edit]

  end
end
