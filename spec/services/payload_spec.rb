require 'rails_helper'

RSpec.describe Payload, type: :service do
  let(:data) { %w[some data] }
  let(:errors) { [] }

  subject { described_class.new(data: data) }

  context 'with data' do
    it 'data' do
      expect(subject.data).to eq data
    end

    it 'no errors' do
      expect(subject.errors).to eq errors
    end

    it 'errors?' do
      expect(subject.errors?).to eq false
    end

    it 'data?' do
      expect(subject.data?).to eq true
    end
  end

  context 'with errors' do
    let(:data) { [] }
    let(:error) { 'something went wrong' }
    let(:error2) { 'something blew up!' }
    let(:error_as_string) { 'something blew up!' }
    let(:errors) { [error, error2] }
    let(:many_errors_at_once) { [error, error] }

    subject { described_class.new(errors: error) }

    it 'no data' do
      expect(subject.data).to eq data
    end

    it 'many errors at once' do
      s = described_class.new(errors: many_errors_at_once)
      expect(s.errors).to eq many_errors_at_once
    end

    it 'error strings' do
      s = described_class.new(errors: error_as_string)
      expect(s.errors).to eq [error_as_string]
    end

    it 'errors' do
      subject.errors = error_as_string
      expect(subject.errors).to eq errors
    end

    it 'errors?' do
      expect(subject.errors?).to eq true
    end

    it 'data?' do
      expect(subject.data?).to eq false
    end
  end
end
