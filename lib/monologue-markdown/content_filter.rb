module MonologueMarkdown
  class ContentFilter
    FILTERS = [Content::Pipeline::Filters::Markdown, Content::Pipeline::Filters::CodeHighlight]

    attr_reader :content

    def initialize(content)
      @content = content
    end

    def run
      pipeline.filter content, opts
    end

    private

    def pipeline
      Content::Pipeline.new FILTERS
    end

    def opts
      { markdown: {type: :md}, code_highlight: {} }
    end
  end
end
