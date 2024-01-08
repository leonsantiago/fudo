class CompressionMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    if compress?(env)
      Rack::Deflater.new(@app).call(env)
    else
      @app.call(env)
    end
  end

  def compress?(env)
    env['HTTP_ACCEPT_ENCODING'].to_s.include?('gzip')
  end
end
