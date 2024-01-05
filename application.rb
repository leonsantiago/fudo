class Application
  def cal(env)
    ['200', { 'Content-type:' => 'application/json' }, ['Return 200 from application']]
  end
end
