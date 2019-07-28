require_relative '../utils/subset_deep_match.rb'

module Rudash
    module Filter
        def filter(collection, *rest_args)
            filter = self.head(rest_args) || self.method(:identity)
    
            if filter.is_a?(Hash)
                slice_matcher = Rudash::SubsetDeepMatch.subset_deep_match?.(filter)
                return self.filter(collection, slice_matcher) 
            end
    
            if collection.is_a?(Array)
                begin
                    return collection.select.with_index { |x, idx| filter.(x, idx) }
                rescue ArgumentError => e
                    begin
                        return collection.select { |x| filter.(x) }
                    rescue ArgumentError => e
                        return collection.select { filter.() }
                    end
                end
            elsif collection.is_a?(Hash)
                begin
                    return collection.select { |k, v| filter.(v, k) }.values
                rescue ArgumentError => e
                    begin
                        return collection.select { |k, v| filter.(v) }.values
                    rescue ArgumentError => e
                        return collection.select { filter.() }.values
                    end
                end
            else
                return []
            end
        end
    end
end
