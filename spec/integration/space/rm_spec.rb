RSpec.describe "`gzr space rm` command", type: :cli do
  it "executes `space rm --help` command successfully" do
    output = `gzr space rm --help`
    expect(output).to eq <<-OUT
Usage:
  gzr space rm SPACE_ID

Options:
  -h, [--help], [--no-help]  # Display usage information

Delete a space. The space must be empty or the --force flag specified to deleted subspaces, dashboards, and looks.
    OUT
  end
end
