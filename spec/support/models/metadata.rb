RSpec.shared_examples 'metadata' do
  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a plot' do
    subject.plot = nil
    expect(subject).to_not be_valid
  end
end
