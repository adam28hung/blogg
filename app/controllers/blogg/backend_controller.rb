module Blogg
  class BackendController < ApplicationController
    before_action :authenticate_administrator!
    layout 'blogg/backend'
  end
end
