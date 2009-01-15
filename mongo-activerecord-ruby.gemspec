Gem::Specification.new do |s|
  s.name = 'mongo-activerecord-ruby'
  s.version = '0.0.1'
  s.platform = Gem::Platform::RUBY
  s.summary = 'ActiveRecord-like models for the 10gen Mongo DB'
  s.description = 'MongoRecord is an ActiveRecord-like framework for the 10gen Monog database. For more information about Mongo, see http://www.mongodb.org.'
  
  s.add_dependency('mongodb-mongo-ruby-driver', ['>= 0.1.1'])

  s.require_paths = ['lib']
  
  s.files = FileList['examples/**/*.rb', 'lib/**/*.rb', 'README.rdoc',
                     'Rakefile', 'mongorecord.gemspec'].to_a
  s.test_files = ['tests/**/*.rb']
  
  s.has_rdoc = true
  s.rdoc_options = ['--main', 'README.rdoc', '--inline-source']
  s.extra_rdoc_files = ['README.rdoc']

  s.author = 'Jim Menard'
  s.email = 'jim@10gen.com'
  s.homepage = 'http://www.mongodb.org'
end
