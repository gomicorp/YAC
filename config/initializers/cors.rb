Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '/embed/*', headers: :any, methods: [:get, :post, :delete, :put, :patch, :options, :head]
  end

  allow do
    origins '*'
    resource '/api/*', headers: :any, methods: [:get, :post, :delete, :put, :patch, :options, :head]
  end
end
