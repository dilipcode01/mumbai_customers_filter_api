# frozen_string_literal: true

# spec/services/distance_calculator_spec.rb
require 'rails_helper'

RSpec.describe DistanceCalculator do
  it 'calculates distance correctly' do
    distance = described_class.new(19.0590317, 72.7553452, 19.1, 72.8).call
    expect(distance).to be_within(1).of(6.0)
  end
end
