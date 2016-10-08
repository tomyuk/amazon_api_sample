# -*- coding: utf-8; mode: ruby -*-

=begin

require(File.expand_path('config/environment.rb', Rails.root.to_s))
#require 'factory_girl'

namespace :cms do

  namespace :develop do

    desc 'テスト用データをデータベースにロードする'
    task prepaire: [:load_users, :load_nodes] do
      puts "Done."
    end


    task :load_users do

      FG = FactoryGirl
      # FG.find_definitions

      Role.destroy_all
      User.destroy_all

      ActiveRecord::Base.connection.execute('alter sequence roles_id_seq restart with 1')
      ActiveRecord::Base.connection.execute('alter sequence users_id_seq restart with 1')

      # roles 
      puts "Loading roles ..."
      role_system = FG.create(:role, name: 'system', label: 'システムロール')
      role_admin = FG.create(:role, name: 'admin', label: 'システム管理ロール')

      roles = []
      (1000..1100).each do |ix|
        roles << FG.create(:group)
      end

      user_system =  FG.create(:user,
        name: 'system',
        label: 'システム',
        encrypted_password: 'x',
        email: 'cms@localhost',
        roles: [role_system])

      # admin users
      puts "Loading users ..."
      user_admin =  FG.create(:user,
        name: 'admin',
        password: 'admin',
        label: 'システム管理者',
        email: 'cmsadmin@localhost',
        roles: [role_admin])
      
      10.times do |ix|
        FG.create(:user,
          name: "admin-#{ix}",
          label: 'システム管理者(#{ix})',
          email: "admin-#{ix}@localhost",
          roles: [role_admin])
      end

      # users
      (1..500).each do |ix|
        r = [ roles[ix / 10] ]
        # r << role_admin if rand(20) == 0
        r += (0..(rand(10))).map {|x| roles[50 + x]}

        user = FG.create(:user, roles: r)
        
        permission = FG.build(:permission, user: user)
        permission.group_master! if ix % 10 == 0
        permission.editable! if ix % 10  > 4
        permission.approvable! if ix % 10 < 4
        permission.deliverable! if ix % 10 == 1
        permission.save
      end
    end
  
    task :load_nodes do
      require(File.expand_path('config/environment.rb', Rails.root.to_s))

      # nodes
      puts "Loading nodes ..."
      Page.delete_all
      Node.delete_all

      ActiveRecord::Base.connection.execute('alter sequence nodes_id_seq restart with 1')

      root = Node.create
      label = 'トップページ'
      root.page = Page.create(id: root.id, name: 'root', label: label, title: label)

      def build_level(parent, path, level)
        level = level + 1
        n = 3
        n.times do |ix|
          node = Node.create.move_to_child_of(parent)

          name = node.id.to_s
          label = "Page (#{node.id})"

          node.page = Page.create(id: node.id, name: name, label: label, title: label)
          npath = path + [ix]
          puts "  Node #{node.page.id}) #{npath}"
          if level <= 4
            if ix < 2
              build_level(node, npath, level)
            end
          end
        end
      end

      build_level(root, [], 0)
      p "Save!"
      root.save

    end
  end
end

=end
