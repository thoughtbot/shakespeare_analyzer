require 'spec_helper'

#require 'shakespeare_analyzer'

describe ShakespeareAnalyzer do
  puts "This is a test!!!"
  it "handles a missing input file" do
    output =  `bin/shakespeare_analyzer`
    expect(output).to eq "No input file; terminating\n"
  end
  it "handles an empty input file" do
    output = `bin/shakespeare_analyzer empty.xml`
    expect(output).to eq "Empty input file; terminating\n"
  end
  it "processes a persona with no speaking" do
    create_testxml("test.xml","<PERSONA>MALCOLM</PERSONA>") 
    output = `bin/shakespeare_analyzer test.xml`
    expect(output).to eq "0 MALCOLM\n"
  end
  it "processes two persona with no speaking" do
    create_testxml "test.xml",<<EOF
    <MAIN>
    <PERSONA>MALCOLM</PERSONA>
    <PERSONA>MACBETH</PERSONA>
    </MAIN>
    EOF
    output = %x{bin/shakespeare_analyzer test.xml}
    expect(output).to eq <<EOF
0 MALCOLM
0 MACBETH
EOF
  end
  it "processes one persona with one speech" do
    create_testxml "test.xml", <<EOF
<main>
<PERSONA>MALCOLM</PERSONA>
<SPEAKER>MALCOLM</SPEAKER>
</main>
EOF
    output = `bin/shakespeare_analyzer test.xml`
    expect(output).to eq <<EOF
1 MALCOLM
EOF
  end
  it "processes two persona with different speeches" do
    create_testxml "test.xml", <<EOF
<main>
<PERSONA>MALCOLM</PERSONA>
<PERSONA>MACBETH</PERSONA>
<SPEAKER>MALCOLM</SPEAKER>
<SPEAKER>MACBETH</SPEAKER>
<SPEAKER>MALCOLM</SPEAKER>
</main>
EOF
    output = `bin/shakespeare_analyzer test.xml`
    expect(output).to eq <<EOF
2 MALCOLM
1 MACBETH
EOF
  end
  it "handles speakers without persona" do
    create_testxml "test.xml", <<EOF
<main>
<PERSONA>MALCOLM</PERSONA>
<SPEAKER>MALCOLM</SPEAKER>
<SPEAKER>MACBETH</SPEAKER>
<SPEAKER>MALCOLM</SPEAKER>
</main>
EOF
    output = `bin/shakespeare_analyzer test.xml`
    expect(output).to eq <<EOF
2 MALCOLM
1 MACBETH
EOF
  end
  it "sorts the output by speaker count" do
    create_testxml "test.xml", <<EOF
<main>
<PERSONA>MALCOLM</PERSONA>
<PERSONA>MACBETH</PERSONA>
<PERSONA>DUNCAN</PERSONA>
<SPEAKER>MALCOLM</SPEAKER>
<SPEAKER>MACBETH</SPEAKER>
<SPEAKER>DUNCAN</SPEAKER>
<SPEAKER>MALCOLM</SPEAKER>
<SPEAKER>MACBETH</SPEAKER>
<SPEAKER>MACBETH</SPEAKER>
</main>
EOF
    output = `bin/shakespeare_analyzer test.xml`
    expect(output).to eq <<EOF
3 MACBETH
2 MALCOLM
1 DUNCAN
EOF
  end
end
