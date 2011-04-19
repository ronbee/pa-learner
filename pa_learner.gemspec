# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pa_learner/version"

Gem::Specification.new do |s|
  s.name        = "pa_learner"
  s.version     = PaLearner::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["ronbee"]
  s.email       = ["ronbee.github@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Implementing Online Passive-Aggressive Algorithms}
  s.description = %q{Passive-Aggressive algorithms are a family of online margin based linear lerners. For further details see: 'Online Passive-Aggressive Algorithms' by Crammer et al. JMLR, 2006.}

  s.rubyforge_project = "pa_learner"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
