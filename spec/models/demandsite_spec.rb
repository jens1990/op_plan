# == Schema Information
#
# Table name: demandsites
#
#  id              :integer          not null, primary key
#  site_id         :integer
#  demand_quantity :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe Demandsite do

  before do
    @demandsite = Demandsite.new(site_id: "1", demand_quantity: "3.14")
  end

  subject { @demandsite }

  it { should respond_to(:demand_quantity) }
#  it { should respond_to(:codename) }

  it { should be_valid }


  describe "when demand quantity is non-positive" do
    before { @demandsite.demand_quantity = -2.0 }
    it { should_not be_valid }
  end
end
