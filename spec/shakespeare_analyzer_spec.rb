require 'spec_helper'

#require 'shakespeare_analyzer'

describe ShakespeareAnalyzer do
  it "handles a missing input file" do
    output =  `bin/shakespeare_analyzer`
    expect(output).to eq "usage: shakespeare_analyzer <input-file>\n"
  end
  it "handles an empty input file by returning an empty result" do
    output = `bin/shakespeare_analyzer empty.xml`
    expect(output).to eq ""
  end
  it "processes a persona with no speaking" do
    create_testxml("test.xml","<PERSONA>MALCOLM</PERSONA>") 
    output = `bin/shakespeare_analyzer test.xml`
    expect(output).to eq "0 Malcolm\n"
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
0 Malcolm
0 Macbeth
EOF
  end
  it "processes one persona with one speech and no lines" do
    create_testxml "test.xml", <<EOF
<MAIN>
<PERSONA>MALCOLM</PERSONA>
<SPEECH>
<SPEAKER>MALCOLM</SPEAKER>
</SPEECH>
</MAIN>
EOF
    output = `bin/shakespeare_analyzer test.xml`
    expect(output).to eq <<EOF
0 Malcolm
EOF
  end
  it "processes two persona with different speeches and one line" do
    create_testxml "test.xml", <<EOF
<main>
<PERSONA>MALCOLM</PERSONA>
<PERSONA>MACBETH</PERSONA>
<SPEECH>
<SPEAKER>MALCOLM</SPEAKER>
<LINE>This is a test</LINE>
</SPEECH>
<SPEECH>
<SPEAKER>MACBETH</SPEAKER>
</SPEECH>
<SPEECH>
<SPEAKER>MALCOLM</SPEAKER>
</SPEECH>
</main>
EOF
    output = `bin/shakespeare_analyzer test.xml`
    expect(output).to eq <<EOF
1 Malcolm
0 Macbeth
EOF
  end
  it "handles speakers without persona" do
    create_testxml "test.xml", <<EOF
<main>
<PERSONA>MALCOLM</PERSONA>
<SPEECH>
<SPEAKER>MALCOLM</SPEAKER>
</SPEECH>
<SPEECH>
<SPEAKER>MACBETH</SPEAKER>
<LINE>This is a test</LINE>
</SPEECH>
<SPEECH>
<SPEAKER>MALCOLM</SPEAKER>
</SPEECH>
</main>
EOF
    output = `bin/shakespeare_analyzer test.xml`
    expect(output).to eq <<EOF
1 Macbeth
0 Malcolm
EOF
  end
  it "sorts the output by speaker count" do
    create_testxml "test.xml", <<EOF
<main>
<PERSONA>MALCOLM</PERSONA>
<PERSONA>MACBETH</PERSONA>
<PERSONA>DUNCAN</PERSONA>
<SPEECH>
<SPEAKER>MALCOLM</SPEAKER>
<LINE></LINE>
</SPEECH>
<SPEECH>
<SPEAKER>MACBETH</SPEAKER>
<LINE></LINE>
<LINE></LINE>
</SPEECH>
<SPEECH>
<SPEAKER>DUNCAN</SPEAKER>
<LINE></LINE>
</SPEECH>
<SPEECH>
<SPEAKER>MALCOLM</SPEAKER>
<LINE></LINE>
</SPEECH>
<SPEECH>
<SPEAKER>MACBETH</SPEAKER>
<LINE></LINE>
</SPEECH>
<SPEECH>
<SPEAKER>LADY MACBETH</SPEAKER>
</SPEECH>
</main>
EOF
    output = `bin/shakespeare_analyzer test.xml`
    expect(output).to eq <<EOF
3 Macbeth
2 Malcolm
1 Duncan
0 Lady Macbeth
EOF
  end
  it "rejects all but HTTP address for an non-local file" do
    analyzer = ShakespeareAnalyzer.new("ftp://testing.xml")
    expect(analyzer.analyze).to be_nil 
  end
  it "downloads an HTTP file from the web" do
    File.delete('play.xml') if FileTest.exists?('play.xml')
    analyzer = ShakespeareAnalyzer.new("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")
    expect(FileTest.exist?('play.xml')).to be_true
  end

  it "handles two speakers on same speech" do
    create_testxml "test.xml", <<EOF
<MAIN>
<PERSONA>MALCOLM</PERSONA>
<SPEECH>
<SPEAKER>MALCOLM</SPEAKER>
<SPEAKER>DUNCAN</SPEAKER>
<LINE>Testing</LINE>
</SPEECH>
</MAIN>
EOF
    output = `bin/shakespeare_analyzer test.xml`
    expect(output).to eq <<EOF
1 Duncan
1 Malcolm
EOF
  end
#  Can't do this; 'ALL' depends on who's in the scene
#  it "handles the ALL speaker" do
#    create_testxml "test.xml", <<EOF
#<MAIN>
#<PERSONA>MALCOLM</PERSONA>
#<PERSONA>DUNCAN</PERSONA>
#<SPEECH>
#<SPEAKER>DUNCAN</SPEAKER>
#<LINE>xxx</LINE>
#</SPEECH
#<SPEECH>
#<SPEAKER>ALL</SPEAKER>
#<LINE>Testing</LINE>
#</SPEECH>
#</MAIN>
#EOF
#    output = `bin/shakespeare_analyzer test.xml`
#    expect(output).to eq <<EOF
#2 Duncan
#1 Malcolm
#EOF
#  end
  
  it "handles a missing file in the initialize method" do
    sa = ShakespeareAnalyzer.new("not_here.xml")
   expect(sa.analyze).to be_nil
  end
end
