require 'blogg/simple_form'
require 'blogg/simple_form_bootstrap'

module Blogg
  class Engine < ::Rails::Engine
    isolate_namespace Blogg
  end
end
