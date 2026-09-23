# Cache-bust main.css by hashing its Sass sources.
#
# jekyll-cache-bust's `bust_css_cache` hashes `assets/_sass/**`, but this repo keeps
# its partials in `_sass/`, so it hashed nothing and every build emitted
# `main.css?v=d41d8cd98f00b204e9800998ecf8427e` (the MD5 of an empty string):
# the fingerprint never changed. This filter hashes `_sass/**/*` plus the
# `assets/css/main.scss` entry point, so the query string changes exactly when
# the compiled stylesheet can change.
#
# Usage: {{ '/assets/css/main.css' | relative_url | bust_sass_cache }}
require 'digest/md5'

module Jekyll
  module SassCacheBust
    def bust_sass_cache(file_name)
      site = @context.registers[:site]
      sources = Dir[File.join(site.source, '_sass', '**', '*')].sort
      sources << File.join(site.source, 'assets', 'css', 'main.scss')
      digest = Digest::MD5.new
      sources.each do |path|
        next unless File.file?(path)
        digest << path.delete_prefix(site.source)
        digest << File.binread(path)
      end
      "#{file_name}?v=#{digest.hexdigest}"
    end
  end
end

Liquid::Template.register_filter(Jekyll::SassCacheBust)
