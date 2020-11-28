unless Redmine::Plugin.installed? 'redmine_hrm'
  Deface::Override.new virtual_path: 'users/show',
                       name: 'user-show-info-hook',
                       insert_top: 'div.splitcontentleft ul:first-child',
                       original: '743d616ab7942bb6bc65bd00626b6a5143247a37',
                       partial: 'hooks/view_users_show_info'
  Deface::Override.new virtual_path: 'users/show',
                       name: 'user-contextual-hook',
                       insert_bottom: 'div.contextual',
                       original: '9d6a7ad6ba0addc68c6b4f6c3b868511bc8eb542',
                       partial: 'hooks/view_users_show_contextual'
end
