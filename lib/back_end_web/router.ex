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

    resources "/company", CompanyController, only: [:index, :show, :update]
    resources "/job_post", JobPostController, only: [:index, :create, :update, :show]
    resources "/saved_job", SavedJobController, only: [:index, :create, :update, :show]
    resources "/saved_file", SavedFileController, only: [:index, :create, :update, :show]
    resources "/applied", AppliedController, only: [:index, :create, :update, :show]
    resources "/files", FileController, only: [:index, :create, :update, :show]
    get "/file_by_user", FileController, :get_by_user

  end
end
