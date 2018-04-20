
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "beauty_product/version"

Gem::Specification.new do |spec|
  spec.name          = "beauty_product"
  spec.version       = BeautyProduct::VERSION
  spec.date          = "2018-04-18"
  spec.authors       = ["Mohammad Adeel"]
  spec.email         = ["Adeel.A.Mhd@gmail.com"]
  spec.files         = ["lib/worlds_best_restaurant/brand.rb", "lib/worlds_best_restaurant/cli.rb", "lib/beauty_product/ingredient.rb", "lib/beauty_product/product.rb", "lib/beauty_product/scraper.rb", "config/environment.rb"]
  spec.summary       = "Provides details for beauty products at cultbeauty.co.uk/sale.html?"
  spec.homepage      = 'https://github.com/AAM77/beautyproduct-cli-app'
  spec.license       = "AGPL-3.0"
  spec.executables   = "bin/beauty_product"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
                        f.match(%r{^(test|spec|features)/})
                        end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", '>= 0'
  spec.add_dependency "nokogiri", "~> 1.8", ">= 1.8.2"
end
