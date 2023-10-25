namespace :init do
  desc "TODO"
  task menu: :environment do
    MenuItem.create(title: '菜单', sign: 'sys-menu') do |sys|
      sys.children.build(title: '校区', icon: 'ri-dashboard-2-line', sign: 'mod-school') do |mod|
        mod.children.build(title: '分校管理', link: 'schools')
        mod.children.build(title: '教师管理', link: 'teachers')
      end
      sys.children.build(title: '学员', icon: 'ri-account-circle-line', sign: 'mod-student') do |mod|
        mod.children.build(title: '学生管理', link: 'students')
        mod.children.build(title: '学习记录', link: 'records')
      end
      sys.children.build(title: '销售', icon: 'ri-layout-3-line', sign: 'mod-sell') do |mod|
        mod.children.build(title: '充值卡管理', link: 'cards')
      end
      sys.children.build(title: '考试', icon: 'ri-file-list-3-line', sign: 'mod-exam') do |mod|
        mod.children.build(title: '试卷管理', link: 'exams')
      end
      sys.children.build(title: '教材', icon: 'ri-stack-line', sign: 'mod-book') do |mod|
        mod.children.build(title: '课本管理', link: 'books')
        mod.children.build(title: '单元管理', link: 'units')
      end
      sys.children.build(title: '设置', icon: 'ri-apps-2-line', sign: 'mod-book') do |mod|
        mod.children.build(title: '数据字典', link: 'dict_items')
        mod.children.build(title: '菜单管理', link: 'menu-items')
        mod.children.build(title: '分组管理', link: 'groups')
        mod.children.build(title: '角色管理', link: 'roles')
        mod.children.build(title: '权限管理', link: 'permissions')

      end
    end
  end

end
