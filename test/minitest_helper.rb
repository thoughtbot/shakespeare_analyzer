if RUBY_ENGINE == 'ruby'
  begin
    require 'simplecov'
    SimpleCov.start do
      add_filter 'test'
      add_filter 'config'
      command_name 'MiniTest'
    end
  rescue LoadError
    warn 'unable to load SimpleCov'
  end
end

require 'thincloud/test'
Dir[File.join('./test/support/**/*.rb')].sort.each { |f| require f }
