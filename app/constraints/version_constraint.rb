class VersionConstraint
  attr_reader :version, :default

  def initialize(version:, default: false)
    @version = version
    @default = default
  end

  def matches?(request)
    default || request.headers.fetch(:accept, '').include?("version=#{version}")
  end
end
