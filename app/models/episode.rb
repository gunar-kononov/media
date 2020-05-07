class Episode < ApplicationRecord
  include Media::Content
  include Media::Metadata
  include Media::Index
end
