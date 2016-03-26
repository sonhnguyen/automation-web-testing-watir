require 'sequel'

if RUBY_PLATFORM == "java"
  require 'jdbc/mysql'
  DB = Sequel.connect("jdbc:mysql://localhost/cs423_testdb?user=tester&password=tester")
else
  require 'mysql'
  DB = Sequel.connect("mysql://localhost/cs423_testdb?user=tester&password=tester")
end

#truncateCrit = DB.tables.select { |tablename|
#  tabnamestr = tablename.to_s
#  tabnamestr.start_with?("mdl_quiz") || tabnamestr.start_with?("mdl_course") || tabnamestr.start_with?("mdl_user_enrolments")
#}

#DatabaseCleaner.clean_with :truncation, {
#  only: truncateCrit
#}

#DatabaseCleaner.strategy = :transaction

Before('@coursecontentmanage-feat-cleanup') do
  @DB = DB
  @GC = []
end


After('@coursecontentmanage-feat-cleanup') do
  @GC.each do |item|
    item.clean(@DB)
  end
end
