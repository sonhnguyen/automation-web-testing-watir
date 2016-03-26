require 'sequel'
require 'database_cleaner'


if RUBY_PLATFORM == "java"
  require 'jdbc/mysql'
  DB = Sequel.connect("jdbc:mysql://localhost/cs423_testdb?user=tester&password=tester")

end

DatabaseCleaner.strategy = :transaction

course_categories = DB.from(:mdl_course_categories)

DatabaseCleaner.cleaning do
  course_categories.insert(name: "MacLenin")
  puts "BEFORE CLEANING:"
  puts course_categories.all
end
puts "AFTER CLEANING:"

DB[:mdl_course_categories].insert(
  name: "MacLenin",
  depth: 1,
  descriptionformat: 1,
  idnumber: "",
  description: "",
  timemodified: 1458969507
)

maclerec = DB[:mdl_course_categories]
  .where(name: "MacLenin")

maclerec.update(
  path: "/#{maclerec.first[:id]}",
  sortorder: DB[:mdl_course_categories].count * 10000
)
