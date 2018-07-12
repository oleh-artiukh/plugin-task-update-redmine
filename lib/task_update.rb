module TaskUpdate
  module Hooks
    class ControllerIssuesTaskUpdate < Redmine::Hook::ViewListener
     
      def controller_issues_edit_before_save(context={})
        user_id = User.current.id.to_s
        issue_id  = context[:params]['id'].to_s
        data_time = context[:params]['issue']['start_date'].to_s
      
        text = context[:params]['issue']['notes'].to_s
        scount = text.length.to_s
        wcount = text.scan(/([\w|\d|\']+)/).length.to_s

        puts 'id задачи : ' + issue_id
        puts 'id юзера : ' + user_id
        puts 'дата : ' + data_time
        puts 'количество символов : ' + scount
        puts 'количество слов разделенные запятой/точкой/пробелом/дефисом: ' + wcount
        
        return ''
      end

      alias_method :controller_issues_new_before_save, :controller_issues_edit_before_save
    end
  end
end