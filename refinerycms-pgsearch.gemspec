Gem::Specification.new do |s|
  s.name              = %q{refinerycms-pgsearch}
  s.version           = %q{0.1}
  s.date              = "#{Date.today.strftime("%Y-%m-%d")}"
  s.summary           = %q{PostgreSQL search handling for Refinery CMS}
  s.description       = %q{Provides extra functionality for searching your frontend website using Refinery CMS.}
  s.homepage          = %q{http://refinerycms.com}
  s.email             = %q{jgwmaxwell@gmail.com}
  s.authors           = ["JGW Maxwell"]
  s.require_paths     = %w(lib)

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  s.add_dependency    'refinerycms-core', '~> 2.0.4'
  s.add_dependency    'pg_search', '~> 0.5'
end
