require 'remote_associations'

module Yardstick
  module V2Client
    class CollectionProxy < RemoteAssociations::CollectionProxy
      def map_results(results)
        @klass.from_array(results)
      end
    end
  end
end
