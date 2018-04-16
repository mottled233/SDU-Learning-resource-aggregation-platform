module ApplicationHelper
    
    def full_title(page_title = '')
        base_title = "山东大学资源聚合平台"
        if page_title.empty?
            base_title
        else
            page_title + ' — ' + base_title
        end
    end
end
