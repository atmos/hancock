require File.expand_path(File.dirname(__FILE__)+'/../spec_helper')

describe "visiting /" do
  before(:each) do
    @last  = Hancock::Consumer.gen(:internal)
    @first = Hancock::Consumer.gen(:visible_to_all)
  end
  describe "when authenticated" do
    describe "as an internal user" do
      before(:each) do
        @user = Hancock::User.gen(:internal)
      end
      it "should greet the user" do
        get '/', {}, :session => {:user_id => @user.id}

        @response.should have_selector("h3:contains('Hello #{@user.first_name} #{@user.last_name}')")
        @response.should have_selector("ul#consumers li a[href='#{@first.url}']:contains('#{@first.label}')")
        @response.should have_selector("ul#consumers li a[href='#{@last.url}']:contains('#{@last.label}')")
      end
    end
    describe "as an external user" do
      before(:each) do
        @user = Hancock::User.gen
      end
      it "should greet the user" do
        get '/', {}, :session => {:user_id => @user.id}

        @response.should have_selector("h3:contains('Hello #{@user.first_name} #{@user.last_name}')")
        @response.should have_selector("ul#consumers li a[href='#{@first.url}']:contains('#{@first.label}')")
        @response.should_not have_selector("ul#consumers li a[href='#{@last.url}']:contains('#{@last.label}')")
      end
    end
  end
  describe "when unauthenticated" do
    it "should prompt the user to login" do
      pending
      visit '/'
      response_body.should be_a_login_form
    end
  end
end
