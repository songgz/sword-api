namespace :init do
  desc "TODO"
  task menu: :environment do
    MenuItem.delete_all

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
        mod.children.build(title: '单词管理', link: 'words')
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

  desc "1TODO"
  task word: :environment do
    Dictionary.where(unit_ids: nil).each do |w|
      if w.unit_ids.blank?
        ids = Unit.where(word_ids: w.id).pluck(:id)
        w.unit_ids = ids
        w.save
      end
    end
  end


  desc "1TODO"
  task learn: :environment do
    b = LearnedBook.find_or_create_by({student_id: '653c68696eec2f1ea8aa1a2a', book_id: '65109c936eec2f38fc2610d5', learn_type: 'read'})
    b.learned_units.build(unit_id: '65109c936eec2f38fc2610d6')
    b.error_words.build(unit_id: '65109c936eec2f38fc2610d6', word_id: '65109c976eec2f38fc2610f9')
    b.error_words.build(unit_id: '65109c936eec2f38fc2610d6', word_id: '65109c966eec2f38fc2610ee')
    b.error_words.build(unit_id: '65109c936eec2f38fc2610d6', word_id: '65109c946eec2f38fc2610d9')
    b.error_words.build(unit_id: '65109c936eec2f38fc2610d6', word_id: '65109c976eec2f38fc2610fa')
    b.save
    p b.errors


  end


  desc "modify"
  task mod_word: :environment do
    Unit.all.each do |u|
      u.words.each do |w|
        begin
        Word.create({
                      book_id: u.book_id,
                      unit_id: u.id,
                      dictionary_id: w.id,
                      word: w.word,
                      book_category: w.book_category,
                      unit_name: u.name,
                      book_name: u.book.name
                    })

      rescue ZeroDivisionError => e
        puts "sgz：#{e.message}"
        end
      end
    end


  end

end
