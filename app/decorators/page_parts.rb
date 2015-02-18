module PageParts

  def content_parts
    @content_parts ||= content_hash
  end

  def content_hash
    parts = content.split('<body>')
    { head: parts.first + '<body>', body: parts.last }.with_indifferent_access
  end

  def content_head
    content_parts[:head] || '<head></head>'
  end 

  def content_body
    content_parts[:body] || '<body></body>'
  end

end
