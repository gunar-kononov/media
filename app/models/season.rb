class Season < ApplicationRecord
  include Media::Content
  include Media::Metadata
  include Media::Index
end
