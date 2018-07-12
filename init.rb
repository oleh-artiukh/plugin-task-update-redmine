Redmine::Plugin.register :task_update_plugin do
  name 'Task Update'
  author 'Oleg Artyukh'
  description 'Plugin for sending information when updating the task for Redmine'
  version '0.0.1'
end

require_dependency 'task_update'