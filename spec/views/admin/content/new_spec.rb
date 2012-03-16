require 'spec_helper'

describe "admin/content/new.html.erb" do
  before do
    admin = stub_model(User, :settings => {:editor => 'simple'}, :admin? => true,
                       :text_filter_name => "", :profile_label => "admin")
    blog = mock_model(Blog, :base_url => "http://myblog.net/")
    article = stub_model(Article).as_new_record
    text_filter = stub_model(TextFilter)

    article.stub(:text_filter) { text_filter }
    view.stub(:current_user) { admin }
    view.stub(:this_blog) { blog }
    
    # FIXME: Nasty. Controller should pass in @categories and @textfilters.
    Category.stub(:all) { [] }
    TextFilter.stub(:all) { [text_filter] }

    assign :article, article


####################HW5##############################
    @normalUser = stub_model(User, :settings => {:editor => 'simple'}, :admin? => false,
                       :text_filter_name => "", :profile_label => "admin")

    @adminUser = admin

    params[:id] = 0
####################HW5##############################

  end

  it "renders with no resources or macros" do
    assign(:images, [])
    assign(:macros, [])
    assign(:resources, [])
    render
  end

  it "renders with image resources" do
    # FIXME: Nasty. Thumbnail creation should not be controlled by the view.
    img = mock_model(Resource, :filename => "foo", :create_thumbnail => nil)
    assign(:images, [img])
    assign(:macros, [])
    assign(:resources, [])
    render
  end

####################HW5##############################
  it "should show an admin a \"Merge With This Article\" button" do
    assign(:images, [])
    assign(:macros, [])
    assign(:resources, [])

    view.stub(:current_user) { @adminUser }
    render
    rendered.should have_selector('input', :value => 'Merge', :type => 'submit')
  end

  it "shouldn't show a non-admin a \"Merge With This Article\" button" do
    assign(:images, [])
    assign(:macros, [])
    assign(:resources, [])

    view.stub(:current_user) { @normalUser }
    render
    rendered.should_not have_selector('input', :value => 'Merge', :type => 'submit')
  end
####################HW5##############################

end
