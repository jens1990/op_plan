# == Schema Information
#
# Table name: supplysites
#
#  id              :integer          not null, primary key
#  site_id         :integer
#  supply_quantity :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe Supplysite do

  before do
    @supplysite = Supplysite.new(site_id: 3, supply_quantity: 3.14)
  end

  subject { @supplysite }

  it { should respond_to(:supply_quantity) }
#  it { should respond_to(:codename) }

  it { should be_valid }



  describe "when supply quantity is non-positive" do
    before { @supplysite.supply_quantity = -2.0 }
    it { should_not be_valid }
  end
end