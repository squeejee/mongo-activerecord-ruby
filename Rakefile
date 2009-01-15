require 'rubygems'
require 'rubygems/specification'
require 'fileutils'
require 'rake'
require 'rake/testtask'
require 'rake/gempackagetask'
require 'rake/contrib/rubyforgepublisher'


# NOTE: some of the tests assume Mongo is running
Rake::TestTask.new do |t|
  t.test_files = FileList['tests/test*.rb']
end

desc "Generate documentation"
task :rdoc do
  FileUtils.rm_rf('html')
  system "rdoc --main README.rdoc --op html --inline-source --quiet README.rdoc `find lib -name '*.rb'`"
end
