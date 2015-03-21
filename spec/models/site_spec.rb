# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  codename   :string(3)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'


describe Site do
  before do
    @site = Site.new(name: "Hannover-Langenhagen", codename: "HLX")
  end

  subject { @site }

  it { should respond_to(:name) }
  it { should respond_to(:codename) }

  it { should be_valid }

  describe "when name is not present" do
    before { @site.name = "" }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @site.name = "a"*51 }
    it { should_not be_valid }
  end

  describe "when codename is too short" do
    before { @site.codename = "aa" }
    it { should_not be_valid }
  end

  describe "when codename is too long" do
    before { @site.codename = "aaaa" }
    it { should_not be_valid }
  end

end
