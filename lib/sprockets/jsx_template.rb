require 'tilt'

module Sprockets
  class JSXTemplate < Tilt::Template
    self.default_mime_type = 'application/javascript'

    CONFIG = Struct.new("Config", :jsx_bin, :compile_options, :root).new

    def self.engine_initialized?
      true
    end

    def initialize_engine
    end

    def prepare
    end

    def evaluate(scope, locals, &block)
      options = CONFIG.compile_options || ENV["JSX_OPTS"] || ""

      dir = nil
      filepath = file()
      if CONFIG.root
        dir = Dir.pwd
        Dir.chdir(CONFIG.root)
        filepath = filepath.dup.sub(CONFIG.root + "/", "")
      end

      content = begin
        %x"#{CONFIG.jsx_bin || ENV["JSX_BIN"] || "jsx"} #{options} #{filepath}"
      rescue Errno::ENOENT => e
        raise Sprockets::ArgumentError.new e
      end

      Dir.chdir(dir) if dir

      content
    end

    # Configure compile option
    #
    # Sprockets::JSXTemplate.configure do |conf|
    #   # The compiler path. It should be executable
    #   conf.jsx_bin = "/path/to/jsx"
    #
    #   # JSX compile options such as "--optimize inline"
    #   conf.compile_options = "--release"
    #
    #   # JSX compiles to $__jsx_classMap = { "/fullpath/asset/foo.jsx": { .. }}
    #   # and call it by JSX.require("/fullpath/asset/foo.jsx")._Main.main$AS(args)
    #   # if conf.root is given as "/fullpath",  classMap will be transform to {"asset/foo.jsx": { .. }}
    #   # then you can call such as JSX.require("asset/foo.jsx")._Main.main$AS(args)
    #   conf.root = "/path/to/asset_root"
    # end
    def self.configure(&block)
      begin
        CONFIG.members.each{|m| CONFIG[m] = nil}
        block.call(CONFIG)
      rescue NoMethodError => e
        raise Sprockets::ArgumentError.new e.message
      end
    end
  end

  register_engine ".jsx", JSXTemplate
end
