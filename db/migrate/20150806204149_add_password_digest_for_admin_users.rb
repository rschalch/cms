class AddPasswordDigestForAdminUsers < ActiveRecord::Migration
  def up
    remove_column 'admin_users', 'hash_password'
    add_column 'admin_users', 'password_digest', :string
  end

  def down
    add_column 'admin_users', 'hash_password', :string, :limit => 40
    remove_column 'admin_users', 'password_digest'
  end
end
