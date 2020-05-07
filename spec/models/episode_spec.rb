require 'rails_helper'
require 'support/model/valid'
require 'support/model/metadata'
require 'support/model/index'

RSpec.describe Episode do
  subject { build_stubbed :episode }

  include_examples 'valid'
  include_examples 'metadata'
  include_examples 'index'
end
