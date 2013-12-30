require 'spec_helper'

describe "contacts/index" do
  before(:each) do
    assign(:contacts, [
      stub_model(Contact,
        :first_name => "First Name",
        :last_name => "Last Name",
        :given_name => "Given Name",
        :photo_url => "Photo Url",
        :gender => "Gender",
        :email => "Email",
        :phone => "Phone",
        :user => nil,
        :identity => nil,
        :network_url => "Network Url",
        :network_username => "Network Username",
        :job_title => "Job Title",
        :organization => "Organization",
        :industry => "Industry",
        :country => "Country",
        :about => "About",
        :notes => "Notes"
      ),
      stub_model(Contact,
        :first_name => "First Name",
        :last_name => "Last Name",
        :given_name => "Given Name",
        :photo_url => "Photo Url",
        :gender => "Gender",
        :email => "Email",
        :phone => "Phone",
        :user => nil,
        :identity => nil,
        :network_url => "Network Url",
        :network_username => "Network Username",
        :job_title => "Job Title",
        :organization => "Organization",
        :industry => "Industry",
        :country => "Country",
        :about => "About",
        :notes => "Notes"
      )
    ])
  end

  it "renders a list of contacts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Given Name".to_s, :count => 2
    assert_select "tr>td", :text => "Photo Url".to_s, :count => 2
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Network Url".to_s, :count => 2
    assert_select "tr>td", :text => "Network Username".to_s, :count => 2
    assert_select "tr>td", :text => "Job Title".to_s, :count => 2
    assert_select "tr>td", :text => "Organization".to_s, :count => 2
    assert_select "tr>td", :text => "Industry".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "About".to_s, :count => 2
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
  end
end
