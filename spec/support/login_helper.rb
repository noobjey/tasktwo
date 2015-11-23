module LoginHelper

  include Capybara::DSL
  Capybara.app = Tasktwo::Application

  def stub_omniauth_github
    OmniAuth.config.test_mode          = true
    OmniAuth.config.mock_auth[:github] = omniauth_github_return
  end

  def omniauth_github_return
    OmniAuth::AuthHash.new({
                             provider:    "github",
                             uid:         "8325508",
                             info:        {
                               nickname: "noobjey"
                             },
                             credentials: {
                               token: "b78f89a9870f3bd00587c5d445c8ab82b953e51f"
                             }
                           })
  end

  def login_user()
    visit root_path
    click_on "Login with Github"
  end
end
