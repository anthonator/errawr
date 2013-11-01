class DummyError < Errawr::Error
  def initialize
    @key = :dummy_key
  end
end