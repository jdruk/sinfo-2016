module ApplicationHelper
    def host_process
        return 'https://sinfo-jdruk.c9users.io/'
    end

    def host_notification
        return 'https://sinfo-jdruk.c9users.io/notifications'
    end

    def bootstrap_class_for flash_type
        case flash_type.to_sym
        when :success
            'alert-success'
        when :error
            'alert-danger'
        when :alert
            'alert-danger'
        when :notice
            'alert-info'
        else
            'alert-warning'
        end
    end

    def render_collection(name, collection,head_name)
        render :partial => "shared/#{name}", :locals => { users: collection, head_name: head_name }
    end

end
