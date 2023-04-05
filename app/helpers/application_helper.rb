module ApplicationHelper
        def current_user
            @current_user ||= User.find_by(id: session[:user_id])
        end
        def full_title(page_title = '')
                base_title = "Ruby on Rails Tutorial Sample App"
            if page_title.empty?
                base_title
            else
                page_title + " | " + base_title
            end
        end
end
