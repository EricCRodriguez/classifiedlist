class AddTranslationToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :secondary_name, :string
  end
end
