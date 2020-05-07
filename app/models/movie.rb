class Movie < ApplicationRecord
  include Media::Content
  include Media::Metadata
end
