# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomerFilter, type: :service do
  let(:file_path) { Rails.root.join('spec/fixtures/customers.txt') }

  describe '#call' do
    subject(:result) { described_class.new(file_path).call }

    it 'returns customers within 100 km of Mumbai' do
      expect(result).to include(
        { user_id: 25, name: 'Pratik' },
        { user_id: 32, name: 'Manish' }
      )
    end

    it 'does not include customers outside 100 km' do
      expect(result).not_to include({ user_id: 3, name: 'Charlie' })
    end

    it 'skips invalid customer lines' do
      expect(result.map { |c| c[:user_id] }).not_to include(4)
    end

    it 'returns results sorted by user_id' do
      expect(result.map { |c| c[:user_id] }).to eq(result.map { |c| c[:user_id] }.sort)
    end
  end
end
