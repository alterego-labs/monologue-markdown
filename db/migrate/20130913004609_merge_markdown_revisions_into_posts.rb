class MergeMarkdownRevisionsIntoPosts < ActiveRecord::Migration
  class Monologue::Post < ActiveRecord::Base
  end

  def up
    Monologue::Post.reset_column_information
    add_column :monologue_posts, :is_markdown, :boolean

    Monologue::Post.reset_column_information

    Monologue::Post.all.each do |post|
      post.is_markdown = false
      post.save(validate: false)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
