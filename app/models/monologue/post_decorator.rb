require 'monologue-markdown/content_filter'

Monologue::Post.class_eval do
  before_validation do
    if self.new_record?
      self.is_markdown = true
    end
  end

  def is_markdown?
    self.is_markdown == true
  end

  def content
    if use_markdown?
      MonologueMarkdown::ContentFilter.new(raw_content).run
    else
      raw_content
    end
  end

  def in_admin? caller
    caller.each do |c|
      return true if c.include? "app/controllers/monologue/admin/posts_controller.rb"
    end
    return false
  end

  private

  def use_markdown?
    self.is_markdown? && !in_admin?(caller)
  end

  def raw_content
    read_attribute :content
  end
end
