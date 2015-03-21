#encoding: UTF-8

require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading) { 'Transportplanung 1.1' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: '| Home' }
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading) { 'Hilfe' }
    let(:page_title) { 'Hilfe' }

    it_should_behave_like "all static pages"

  end

  describe "About page" do
    before { visit about_path }
    let(:heading) { 'Über uns' }
    let(:page_title) { 'Über uns' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading) { 'Kontakt' }
    let(:page_title) { 'Kontakt' }

    it_should_behave_like "all static pages"
  end


  it "should have the right links on the layout" do
    visit root_path
    click_link "Über uns"
    page.should have_selector 'title', text: full_title('Über uns')
    click_link "Hilfe"
    page.should have_selector 'title', text: full_title('Hilfe')
    click_link "Kontakt"
    page.should have_selector 'title', text: full_title('Kontakt')
    click_link "Home"
    click_link "Melde Dich JETZT an!"
    page.should have_selector 'title', text: full_title('Anmeldung')
    click_link "Home"
    page.should have_selector 'h1', text: 'Transportplanung 1.1 (Demoanwendung mit Tests)'
    click_link "Transportplanung 1.1"
    page.should have_selector 'h1', text: 'Transportplanung 1.1 (Demoanwendung mit Tests)'
  end


end