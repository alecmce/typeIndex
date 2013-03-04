require 'erb'
require 'fileutils'

src = "src"
bin = "bin"
main = "Test"

width = 800
height = 600
fps = 60
background = "FFFFFF"

task :default do
    `haxelib run nme help`
end

task :flash => [:build_flash, :launch_flash]
task :html5 => [:build_html5, :prepare_html, :launch_html5]

task :build_flash do
    params = []
    params << "-cp #{src}"
    params << "-main #{main}.hx"
    params <<  "-swf #{bin}/#{main}.swf"
    params << "-swf-header #{width}:#{height}:#{fps}:#{background}"
    haxe(params)
end

task :launch_flash do
    `open #{bin}/#{main}.swf`
end

task :build_html5 do
    params = []
    params << "-cp #{src}"
    params << "-main #{main}.hx"
    params << "-js #{bin}/#{main}.js"
    haxe(params)
end

task :prepare_html do
    html = IndexHtml.new("build", "bin")
    html.title = "#{main}"
    html.bg_color = "#{background}"
    html.width = "#{width}px"
    html.height = "#{height}px"
    html.fps = "#{fps}"
    html.target = "#{main}.js"
    html.debug = true
    html.trace = true
    html.save()
end

task :launch_html5 do
  `open #{bin}/index.html` if File.exist? "#{bin}/#{main}.js"
end

def haxe(args)
    line = "haxe #{args.join(" ")}"
    puts "#{line}"
    `#{line}`
end

class IndexHtml
  include ERB::Util
  attr_accessor :title, :bg_color, :width, :height, :fps, :target, :trace, :debug

  def initialize(build, bin)
    @build = build
    @bin = bin
    @template = "build/index.html.erb"
  end

  def render()
    ERB.new(File.read(@template)).result(binding)
  end

  def save()
    File.open("#{@bin}/index.html", "w") do |f|
      f.write(render)
    end
    copy_debug if @debug
  end

  def copy_debug
    debug_script = "webgl-debug.js"
    if @debug
      FileUtils.copy "#{@build}/#{debug_script}", "#{@bin}/#{debug_script}"
    else
      FileUtils.remove "#{@bin}/#{debug_script}"
    end
  end

end