require 'sequel'


if RUBY_PLATFORM == "java"
  require 'jdbc/mysql'
  DB = Sequel.connect("jdbc:mysql://localhost/cs423_testdb?user=tester&password=tester")
end

puts "MDL_COURSE"
puts DB[:mdl_course].all
puts "MDL_COURSE_CATEGORIES"
puts DB[:mdl_course_categories].all

DB[:mdl_course].where('fullname = ?', "Database").delete
DB[:mdl_course_categories].where('name = ?', "CS").delete
