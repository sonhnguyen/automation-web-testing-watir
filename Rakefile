require 'rake'

task :default => [:moodle]

REPORTS_PATH = "reports"
REPORTFILE = "feature-report.html"
RERUNFILE = "feature-rerun.txt"

task :run_cucumber_and_report, [:reportfile, :rerunfile] do |t, args|
  Dir.chdir "moodle"
  UPLOAD_PATH = Dir.pwd + "/uploads"

  sh "cucumber uploadpath=#{UPLOAD_PATH} reportpath=#{REPORTS_PATH} -f pretty -f html --out #{REPORTS_PATH}/#{args[:reportfile]} -f rerun --out #{REPORTS_PATH}/#{args[:rerunfile]}"
end

task :moodle do
  Rake::Task[:run_cucumber_and_report].invoke(REPORTFILE, RERUNFILE)
end
