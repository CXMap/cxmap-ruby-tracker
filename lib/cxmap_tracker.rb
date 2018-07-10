require 'dry-validation'
require 'active_support'
require 'active_support/core_ext'
# 
Dir.glob(File.expand_path("cxmap_tracker/schemas/*.rb", __dir__)).each do |path|
  require path
end
require 'cxmap_tracker/events'
require 'cxmap_tracker/version'

require 'cxmap/cxmap_core'
require 'cxmap/tracker'

module CXMap
  mattr_reader :tracker_name
  @@tracker_name = 'cxmap-ruby'

  mattr_reader :tracker_version
  @@tracker_version = CXMapTracker::VERSION

  #  config.tracker_timeout = 10 # 
  mattr_accessor :tracker_timeout
  @@tracker_timeout = 10
end
