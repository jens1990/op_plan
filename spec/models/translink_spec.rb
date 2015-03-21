# == Schema Information
#
# Table name: translinks
#
#  id                 :integer          not null, primary key
#  supplysite_id      :integer
#  demandsite_id      :integer
#  unit_cost          :float
#  transport_quantity :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe Translink do

  before do
    @translink = Translink.new(supplysite_id: 1, demandsite_id: 1, unit_cost: 0.14)
  end

  subject { @translink }


  it { should respond_to(:unit_cost) }

#  it { should be_valid }


  describe "when unit cost is non-positive" do
    before { @translink.unit_cost = -2.0 }
    it { should_not be_valid }
  end

  describe "when transport quantitiy is non-positive" do
    before { @translink.transport_quantity = -2.0 }
    it { should_not be_valid }
  end
end
