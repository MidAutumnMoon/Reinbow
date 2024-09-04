# frozen_string_literal: true

require_relative "./lib/reinbow"

Gem::Specification.new do |spec|

    spec.name                  = "reinbow"
    spec.version               = Reinbow::VERSION
    spec.authors               = [ "MidAutumnMoon" ]
    spec.description           = "Ruby gem for colorizing text in terminal"
    spec.summary               = "Ruby gem for colorizing text in terminal"
    spec.homepage              = "https://github.com/MidAutumnMoon/Reinbow"
    spec.license               = "BSD-3-Clause"
    spec.required_ruby_version = ">= 3.3.0"

    spec.metadata = {
        "rubygems_mfa_required" => "true",
        "homepage_uri" => spec.homepage,
        "source_code_uri" => spec.homepage,
    }

    spec.files = Dir[
        "lib/**/*",
        "README.md",
        "LICENSE"
    ]

    spec.require_paths = [ "lib" ]

end
