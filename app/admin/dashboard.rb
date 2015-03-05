ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  controller do
    skip_before_filter :verify_authorization_token
    http_basic_authenticate_with name: 'danilo', password: 'TripviseMe019', if: :admin_controller?

    def admin_controller?
      self.class < ActiveAdmin::BaseController
    end
  end

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        span I18n.t('active_admin.dashboard_welcome.welcome')
        small I18n.t('active_admin.dashboard_welcome.call_to_action')
      end
    end
  end
end
