require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/main/items" do
  before(:each) do
    render 'main/items'
  end
  
  it "should have h1 tag with the text: 'Item Dashboard'"do
    response.should have_tag('h1',"Item Dashboard")
  end
  
  it "should have <p> tag with text: 'Summary of Items'"do
    response.should have_tag('p','Summary of Items')
  end
end
