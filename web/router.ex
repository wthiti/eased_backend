defmodule EasedBackend.Router do
  use EasedBackend.Web, :router

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

  pipeline :auth_student do
    plug EasedBackend.Auth, role: "student"
  end

  pipeline :auth_teacher do
    plug EasedBackend.Auth, role: "teacher"
  end

  scope "/", EasedBackend do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", EasedBackend do
    pipe_through :api

    post "/session", SessionController, :create

    scope "/student" do
      pipe_through :auth_student

      get "/requests", RequestController, :student_index
      get "/request", RequestController, :student_new
      get "/request/:id", RequestController, :student_show
      put "/request/:id", RequestController, :student_update
      post "/request", RequestController, :student_create
    end

    scope "/teacher/" do
      pipe_through :auth_teacher

      get "/requests", RequestController, :teacher_index
      get "/request/:id", RequestController, :teacher_show
      put "/request/:id", RequestController, :teacher_update
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", EasedBackend do
  #   pipe_through :api
  # end
end
