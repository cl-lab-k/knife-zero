require 'chef/knife/zero_bootstrap'

class TC_ZeroBootstrap < Test::Unit::TestCase
  sub_test_case "called with no options" do
    def setup
      @app = Chef::Knife::ZeroBootstrap.new
      @app.merge_configs
      require 'chef/knife/ssh'
      Chef::Knife::ZeroBootstrap.load_deps
    end

    test "returns true from Chef::Config[:knife_zero]" do
      assert_true(Chef::Config[:knife_zero])
    end

    test "returns changed value from core" do
      assert_equal("chef-full", @app.config[:distro])
    end

    test "returns BootstrapSsh via knife_ssh" do
      ssh = @app.knife_ssh
      assert_kind_of(Chef::Knife::BootstrapSsh, ssh)
    end

    sub_test_case "overwrite ssh_configration from ssh/config" do
      test "overwrite port number" do
        stub(Net::SSH).configuration_for { {port: 10022} }
        ssh = @app.knife_ssh
        assert_equal(10022, ssh.config[:port])
      end
    end
  end
end
