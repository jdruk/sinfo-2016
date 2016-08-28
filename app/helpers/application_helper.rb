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
            'alert-error'
        when :alert
            'alert-block'
        when :notice
            'alert-info'
        else
            'alert-info'
        end
    end

    def render_collection(name, collection,head_name)
        render :partial => "shared/#{name}", :collection => collection, :locals => { users: collection, head_name: head_name }
    end

end
