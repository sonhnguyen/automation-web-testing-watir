require 'sequel'

if RUBY_PLATFORM == "java"
  require 'jdbc/mysql'
  DB = Sequel.connect("jdbc:mysql://localhost/cs423_testdb?user=tester&password=tester")
else
  require 'mysql'
  DB = Sequel.connect("mysql://localhost/cs423_testdb?user=tester&password=tester")
end

Before('@cleanup') do
  @DB = DB
  @GC = []
end

After('@cleanup') do
  @GC.each do |item|
    item.clean(@DB)
  end
end
