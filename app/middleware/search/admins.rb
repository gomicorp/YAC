module Search
  class Admins
    def initialize(app)
      @app = app
    end

    def call(env)
      if env['PATH_INFO'] == '/search/admins'
        request = Rack::Request.new(env)
        terms = User.search_by_terms(request.params['term'], request.params['page'])
        [200, { 'Content-Type' => 'application/json' }, [data_format(terms).to_json]]
      else
        @app.call(env)
      end
    end

    def data_format(results)
      {
        items: results.select(fetch_columns),
        total_count: results.count
      }
    end

    def fetch_columns
      %i[id email name image_url]
    end
  end
end
