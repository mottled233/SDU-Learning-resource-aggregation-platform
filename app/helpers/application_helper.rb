module ApplicationHelper
    include SessionsHelper
    
    def full_title(page_title = '')
        base_title = "山东大学资源聚合平台"
        if page_title.empty?
            base_title
        else
            page_title + ' — ' + base_title
        end
    end
    
    def time_to_chinese(time)
        time = time.sub(/year(s)?/, "年")
        time = time.sub(/month(s)?/, "月")
        time = time.sub(/day(s)?/, "日")
        time = time.sub(/hour(s)?/, "小时")
        time = time.sub(/minute(s)?/, "分钟")
        time = time.sub(/second(s)?/, "秒")
        time = time.sub(/about/,"")
    end
    
    def short_digest(text, length=20)
        digest = text
        if digest.length>length
          digest = digest[0,length]+"..."
        end
        return digest
    end
end
