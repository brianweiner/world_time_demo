if ENV['RAILS_ENV'] =='test'
  Capybara.javascript_driver = :webkit
end