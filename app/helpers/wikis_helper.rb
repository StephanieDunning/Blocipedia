module WikisHelper
  def user_is_authorized_to_delete_wiki?
    current_user == @wiki.user || current_user.admin?
  end

  def markdown_to_html(markdown_string)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    output = markdown.render(markdown_string)
    "<div class='markdown'>#{output}</div>".html_safe
  end
end
