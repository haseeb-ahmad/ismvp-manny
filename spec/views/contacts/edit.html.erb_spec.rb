require 'spec_helper'

describe "contacts/edit" do
  before(:each) do
    @contact = assign(:contact, stub_model(Contact,
      :first_name => "MyString",
      :last_name => "MyString",
      :given_name => "MyString",
      :photo_url => "MyString",
      :gender => "MyString",
      :email => "MyString",
      :phone => "MyString",
      :user => nil,
      :identity => nil,
      :network_url => "MyString",
      :network_username => "MyString",
      :job_title => "MyString",
      :organization => "MyString",
      :industry => "MyString",
      :country => "MyString",
      :about => "MyString",
      :notes => "MyString"
    ))
  end

  it "renders the edit contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contact_path(@contact), "post" do
      assert_select "input#contact_first_name[name=?]", "contact[first_name]"
      assert_select "input#contact_last_name[name=?]", "contact[last_name]"
      assert_select "input#contact_given_name[name=?]", "contact[given_name]"
      assert_select "input#contact_photo_url[name=?]", "contact[photo_url]"
      assert_select "input#contact_gender[name=?]", "contact[gender]"
      assert_select "input#contact_email[name=?]", "contact[email]"
      assert_select "input#contact_phone[name=?]", "contact[phone]"
      assert_select "input#contact_user[name=?]", "contact[user]"
      assert_select "input#contact_identity[name=?]", "contact[identity]"
      assert_select "input#contact_network_url[name=?]", "contact[network_url]"
      assert_select "input#contact_network_username[name=?]", "contact[network_username]"
      assert_select "input#contact_job_title[name=?]", "contact[job_title]"
      assert_select "input#contact_organization[name=?]", "contact[organization]"
      assert_select "input#contact_industry[name=?]", "contact[industry]"
      assert_select "input#contact_country[name=?]", "contact[country]"
      assert_select "input#contact_about[name=?]", "contact[about]"
      assert_select "input#contact_notes[name=?]", "contact[notes]"
    end
  end
end
