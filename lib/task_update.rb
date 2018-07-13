module TaskUpdate
  module Hooks
    class ControllerIssuesTaskUpdate < Redmine::Hook::ViewListener
     
      def controller_issues_edit_before_save(context={})

        if not context[:params]['issue'].nil? and not context[:params].nil?

          error  = ''
          scount = ''
          wcount = ''
          mused  = ''

          User.current.id.nil? ? error='Не удалось определить id пользователя' : user_id=User.current.id.to_s
          context[:params]['id'].nil? ? error='Не удалось определить id задачи' : issue_id=context[:params]['id'].to_s
          context[:params]['issue']['start_date'].nil? ? data_time='Дата не установлена' : data_time=context[:params]['issue']['start_date'].to_s
          context[:params]['issue']['notes'].nil? ? text='' : text=context[:params]['issue']['notes'].to_s
          context[:params]['issue']['description'].nil? ? desc='' : desc=context[:params]['issue']['description'].to_s

          if not text.nil? or not desc.nil?
            text_desc = text +' '+ desc

            scount = text_desc.length.to_s
            wcount = text_desc.scan(/([\w|\d|\']+)/).length.to_s
            
            count, total, tmp_c, mused = 0, 0, '', ''
            wcount_tmp = text_desc.chars.sort
            
            wcount_tmp.each do |val|
              if val =~ /\w+/
                if val == tmp_c
                  count = count + 1
                  mused = val if count > total
                else
                  tmp_c = val
                  total = count if count > total
                  count = 1
                end
                total = count if count > total
              end
            end
          end

          if error.empty?
            result = DomainStore.first
            
            if not result.nil?
              domain = result.domain
              
              if domain.index('http').nil?
                domain = 'http://'+domain
              end

              uri = URI(domain)
              req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
              req.body = {
                data: {
                  issue_id: issue_id, 
                  user_id: user_id,
                  data_time: data_time,
                  report: {
                    scount: scount,
                    wcount: wcount,
                    mused: mused,
                  },
                },
              }.to_json

              #puts 'REQ.BODY========================================'
              #puts req.body
              #puts 'REQ.BODY========================================'

              begin
                res = Net::HTTP.start(uri.hostname, uri.port) do |http|
                  http.request(req)
                end
              rescue Exception => err
                puts err
              end

            end
          end

        end
        return ''
      end

      alias_method :controller_issues_update_before_save, :controller_issues_edit_before_save
    end
  end
end