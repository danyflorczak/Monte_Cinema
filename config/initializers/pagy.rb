# frozen_string_literal: true

# Pagy initializer file (5.10.1)
# Customize only what you really need and notice that the core Pagy works also without any of the following lines.
# Should you just cherry pick part of this file, please maintain the require-order of the extras                           # default
Pagy::DEFAULT[:items] = 10 # default
# Bootstrap extra: Add nav, nav_js and combo_nav_js helpers and templates for Bootstrap pagination
# See https://ddnexus.github.io/pagy/extras/bootstrap
require "pagy/extras/bootstrap"
Pagy::DEFAULT.freeze
