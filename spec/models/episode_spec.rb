require 'rails_helper'
require 'support/models/valid'
require 'support/models/metadata'
require 'support/models/index'

RSpec.describe Episode do
  subject { build_stubbed :episode }

  include_examples 'valid'
  include_examples 'metadata'
  include_examples 'index'
end
