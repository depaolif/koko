require File.expand_path('../../config/boot', __FILE__)

require File.expand_path('../../config/environment', __FILE__)

require 'clockwork'

include Clockwork

module Clockwork

every(1.day, 'job Deleting Unused Song Record in DB') { Song.delete_unused }

end
