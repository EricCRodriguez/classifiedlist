class AddSlugToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :slug, :string
    add_index :pages, :slug, unique: true
    remove_column :pages, :url
  end
end
