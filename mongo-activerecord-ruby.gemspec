Gem::Specification.new do |s|
  s.name = 'mongo_record'
  s.version = '0.1.1'
  s.platform = Gem::Platform::RUBY
  s.summary = 'ActiveRecord-like models for the 10gen Mongo DB'
  s.description = 'MongoRecord is an ActiveRecord-like framework for the 10gen Mongo database. For more information about Mongo, see http://www.mongodb.org.'
  
  s.add_dependency('mongodb-mongo', ['>= 0.5.4'])

  s.require_paths = ['lib']
  
  s.files = ['examples/tracks.rb', 'lib/mongo_record.rb',
             'lib/mongo_record/base.rb',
             'lib/mongo_record/convert.rb',
             'lib/mongo_record/log_device.rb',
             'lib/mongo_record/sql.rb',
             'lib/mongo_record/subobject.rb',
             'README.rdoc', 'Rakefile', 'mongo-activerecord-ruby.gemspec']
  s.test_files = ['tests/address.rb',
                  'tests/course.rb',
                  'tests/student.rb',
                  'tests/test_log_device.rb',
                  'tests/test_mongo.rb',
                  'tests/test_sql.rb',
                  'tests/track2.rb',
                  'tests/track3.rb']
  
  s.has_rdoc = true
  s.rdoc_options = ['--main', 'README.rdoc', '--inline-source']
  s.extra_rdoc_files = ['README.rdoc']

  s.author = 'Jim Menard'
  s.email = 'jim@10gen.com'
  s.homepage = 'http://www.mongodb.org'
end
