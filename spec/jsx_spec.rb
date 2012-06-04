require "spec_helper"

describe Sprockets::JSXTemplate do
  let(:env) do
    Sprockets::Environment.new.tap do |env|
      env.append_path(FIXTURE_PATH)
    end
  end

  it "should compile" do
    asset = env["hello.jsx"]
    asset.to_s.match /^var JSX=/
    asset.content_type.should == "application/javascript"
    asset.to_s.should match /"#{FIXTURE_PATH}/
  end

  it "should compile by relative path" do
    Sprockets::JSXTemplate.configure do |conf|
      conf.root = FIXTURE_PATH
    end
    asset = env["hello.jsx"]
    asset.to_s.match /^var JSX=/
    asset.content_type.should == "application/javascript"
    asset.to_s.should_not match /"#{FIXTURE_PATH}/
  end

  it "should be raise if `jsx` is not found" do
    Sprockets::JSXTemplate.configure do |conf|
      conf.jsx_bin = "foo"
    end
    lambda { env["hello.jsx"] }.should raise_error(Sprockets::ArgumentError)
  end

  it "should be configure by class method" do
    Sprockets::JSXTemplate.configure do |conf|
      conf.jsx_bin = "foo"
      conf.compile_options = "--bar"
    end
    conf = Sprockets::JSXTemplate::CONFIG
    conf.jsx_bin.should == "foo"
    conf.compile_options.should == "--bar"
  end

  it "should be reset configure for each time" do
    Sprockets::JSXTemplate.configure {|conf| conf.jsx_bin = "bar"}
    Sprockets::JSXTemplate.configure {|conf|}
    Sprockets::JSXTemplate::CONFIG.jsx_bin.should be_nil
  end

  it "should be raise if invalid config method call" do
    lambda do
      Sprockets::JSXTemplate.configure do |conf|
        conf.invalid_property = "hello"
      end
    end.should raise_error(Sprockets::ArgumentError)
  end
end
