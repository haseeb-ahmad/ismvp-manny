require 'spec_helper'

describe "contacts/show" do
  before(:each) do
    @contact = assign(:contact, stub_model(Contact,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Given Name/)
    rendered.should match(/Photo Url/)
    rendered.should match(/Gender/)
    rendered.should match(/Email/)
    rendered.should match(/Phone/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Network Url/)
    rendered.should match(/Network Username/)
    rendered.should match(/Job Title/)
    rendered.should match(/Organization/)
    rendered.should match(/Industry/)
    rendered.should match(/Country/)
    rendered.should match(/About/)
    rendered.should match(/Notes/)
  end
end
