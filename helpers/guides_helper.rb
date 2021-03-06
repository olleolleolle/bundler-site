module GuidesHelper
  LOCALIZABLE_REGEX = /localizable\/(v\d+.\d+\/.*)\.(.{2})\.html/
  ADDITIONAL_GUIDES = %w(./source/issues.html.md)
  
  def guides
    guides = Dir.glob("./source/#{current_version}/*").select { |filename| proper_md_file?(filename) }
    localizable_guides = Dir.glob("./source/localizable/#{current_version}/guides/*.en.html.md")

    (guides + localizable_guides + ADDITIONAL_GUIDES).map do |filename|
      filename = filename.sub(/^\.\/source\//, '').sub(/\.md$/, '')

      { filename: filename, title: sitemap.find_resource_by_path(filename).metadata[:page][:title] }
    end.select { |page| page[:title] }.sort_by { |page| page[:title] }
  end

  def link_to_guide(page)
    filename = process_localizable(page[:filename])
    link_to page[:title], filename, class: 'truncate-text'
  end

  def current_guide?(filename)
    return 'active' if current_page.path == filename
    matched = filename.match(LOCALIZABLE_REGEX)
    return '' unless matched
    return 'active' if current_page.path == "#{matched[1]}.html"
    ''
  end

  private

  def proper_md_file?(filename)
    File.file?(filename) && filename.end_with?('.md') && filename !~ /bundle_/
  end

  def process_localizable(filename)
    matched = filename.match(LOCALIZABLE_REGEX)
    return filename unless matched

    "#{matched[1]}.html"
  end
end
