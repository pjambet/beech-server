module ApplicationHelper

  def full_url_for_path(path)
    path
  end

  # Implements the Paul Irish IE detection hack in haml.
  # See http://paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/
  # for details on this hack.
  def cc_html(options={}, &blk)
    attrs = options.map { |(k, v)| " #{h k}='#{h v}'" }.join('')
    [ "<!--[if lt IE 7]> <html#{attrs} class='lt-ie9 lt-ie8 lt-ie7'> <![endif]-->",
      "<!--[if IE 7]> <html#{attrs} class='lt-ie9 lt-ie8'> <![endif]-->",
      "<!--[if IE 8]> <html#{attrs} class='lt-ie9'> <![endif]-->",
      "<!--[if gt IE 8]><!--> <html#{attrs}> <!--<![endif]-->",
      capture_haml(&blk).strip,
      "</html>"
    ].join("\n")
  end
  def h(str); Rack::Utils.escape_html(str); end

  def ie_js
    [ "<!--[if lt IE 9]>",
      javascript_include_tag('html5'),
      "<![endif]-->"
    ].join("\n")
  end
end
