Redmine::Plugin.register 'plugin-task-update-redmine' do
  menu :application_menu, 'plugin-task-update-redmine', { :controller => 'task_update_plugin', :action => 'index' }, :caption => 'TaskUpdatePlugin'
  name 'Task Update'
  author 'Oleg Artyukh'
  description 'Plugin for sending information when updating the task for Redmine'
  version '0.0.1'
end

require_dependency 'task_update'