module ApplicationHelper
    def host_process
        return 'https://sinfo-jdruk.c9users.io/'
    end

    def host_notification
        return 'https://sinfo-jdruk.c9users.io/notifications'
    end

    def bootstrap_class_for flash_type
        flash_type = flash_type.to_sym
        case flash_type
        when :success
            "alert-success"
        when :error
            "alert-error"
        when :alert
            "alert-block"
        when :notice
            "alert-info"
        end
    end
    
end
