require_relative './lib/version'

Gem::Specification.new do |spec|
    spec.name          = "pet_sitter_app"
    spec.version       = PetSitterApp::VERSION
    spec.authors       = ["Vanessa Denardin"]
    spec.email         = "vanessa.denardin@gmail.com"
    spec.license       = "MIT"
    spec.homepage      = "https://github.com/vanessadenardin/pet-sitter-app"
    spec.summary       = "Terminal application to help pet sitters to manage clients and tasks."
    spec.files         = Dir['**/**'].grep_v(/.gem$/)
    spec.require_paths = ["lib"]

    spec.add_development_dependency "bundler", "~> 1.16"
    spec.add_development_dependency "ruby-debug-ide", "~> 0.7.2"
end
