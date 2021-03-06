RSpec.describe "`gzr group` command", type: :cli do
  it "executes `group --help` command successfully" do
    output = `gzr group --help`
    expect(output).to eq <<-OUT
Commands:
  gzr group help [COMMAND]          # Describe subcommands or one specific subcommand
  gzr group ls                      # List the groups that are defined on this server
  gzr group member_groups GROUP_ID  # List the groups that are members of the given group
  gzr group member_users GROUP_ID   # List the users that are members of the given group

    OUT
  end
end
