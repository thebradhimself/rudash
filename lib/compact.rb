require 'reject.rb'
require 'isNil.rb'

module Compact
    extend Reject
    extend IsNil
    def compact
        compactProc = -> (array) {
            if !array.is_a?(Array)
                return []
            end

            self.reject[array, self.isNil]
        }

        compactProc
    end
end