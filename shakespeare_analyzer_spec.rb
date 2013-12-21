require_relative 'shakespeare_analyzer'
describe "ShakespeareAnalyzer" do
  it "analyzer xml string" do
    #macbeth_xml = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
    macbeth_xml = %Q(
    <PLAY>
    <ACT>
    <SCENE>
    <SPEECH>
    <SPEAKER>First Witch</SPEAKER>
    <LINE>When shall we three meet again</LINE>
    <LINE>In thunder, lightning, or in rain?</LINE>
    <LINE>And I prevail finally</LINE>
    </SPEECH>
    <SPEECH>
        <SPEAKER>Second Witch</SPEAKER>
        <LINE>When the hurlyburly's done,</LINE>
        <LINE>When the battle's lost and won.</LINE>
        </SPEECH>
        <SPEECH>
        <SPEAKER>Third Witch</SPEAKER>
        <LINE>That will be ere the set of sun.</LINE>
        </SPEECH>
        </SCENE>
        <SCENE>
        <SPEECH>
        <SPEAKER>First Witch</SPEAKER>
        <LINE>When shall we three meet again</LINE>
        <LINE>In thunder, lightning, or in rain?</LINE>
        <LINE>And I prevail finally</LINE>
        </SPEECH>
        <SPEECH>
            <SPEAKER>Second Witch</SPEAKER>
            <LINE>When the hurlyburly's done,</LINE>
            <LINE>When the battle's lost and won.</LINE>
            </SPEECH>
            <SPEECH>
            <SPEAKER>Third Witch</SPEAKER>
            <LINE>That will be ere the set of sun.</LINE>
            </SPEECH>
            </SCENE>
        </ACT>
        <ACT>
        <SCENE>
        <SPEECH>
        <SPEAKER>First Witch</SPEAKER>
        <LINE>When shall we three meet again</LINE>
        <LINE>In thunder, lightning, or in rain?</LINE>
        <LINE>And I prevail finally</LINE>
        </SPEECH>
        <SPEECH>
            <SPEAKER>Second Witch</SPEAKER>
            <LINE>When the hurlyburly's done,</LINE>
            <LINE>When the battle's lost and won.</LINE>
            </SPEECH>
            <SPEECH>
            <SPEAKER>Third Witch</SPEAKER>
            <LINE>That will be ere the set of sun.</LINE>
            </SPEECH>
            </SCENE>
            <SCENE>
            <SPEECH>
            <SPEAKER>First Witch</SPEAKER>
            <LINE>When shall we three meet again</LINE>
            <LINE>In thunder, lightning, or in rain?</LINE>
            <LINE>And I prevail finally</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>Second Witch</SPEAKER>
                <LINE>When the hurlyburly's done,</LINE>
                <LINE>When the battle's lost and won.</LINE>
                </SPEECH>
                <SPEECH>
                <SPEAKER>Fourth Witch</SPEAKER>
                <LINE>That will be ere the set of sun.</LINE>
                </SPEECH>
                </SCENE>
            </ACT>
        </PLAY>
    )
    doc =  Nokogiri::XML(macbeth_xml) #Nokogiri::HTML(open(@xml))
    analyzer = ShakespeareAnalyzer.new(doc)
    result = analyzer.analyze
    expect(result).to eq({"First Witch"=>12, "Second Witch"=>8, "Third Witch"=>3,"Fourth Witch" => 1})
  end
  
  it "analyzes xml file" do
    f = File.open("macbeth.xml")
    doc =  Nokogiri::XML(f)
   #  p doc
    analyzer = ShakespeareAnalyzer.new(doc)
    result = analyzer.analyze
    expect(result).to eq({"First Witch"=>62, "Second Witch"=>27, "Third Witch"=>27, "ALL"=>24, "DUNCAN"=>70, "MALCOLM"=>212, "Sergeant"=>35, "LENNOX"=>73, "ROSS"=>135, "MACBETH"=>718, "BANQUO"=>113, "ANGUS"=>21, "LADY MACBETH"=>265, "Messenger"=>23, "FLEANCE"=>2, "Porter"=>46, "MACDUFF"=>180, "MACBETHLENNOX"=>1, "DONALBAIN"=>10, "Old Man"=>11, "ATTENDANT"=>1, "First Murderer"=>30, "Second Murderer"=>15, "Both Murderers"=>2, "Servant"=>5, "Third Murderer"=>8, "Lords"=>3, "HECATE"=>39, "Lord"=>21, "First Apparition"=>2, "Second Apparition"=>4, "Third Apparition"=>5, "LADY MACDUFF"=>41, "Son"=>20, "Doctor"=>45, "Gentlewoman"=>23, "MENTEITH"=>12, "CAITHNESS"=>11, "SEYTON"=>5, "SIWARD"=>30, "Soldiers"=>1, "YOUNG SIWARD"=>7})
    f.close
  end
  
  it "analyzes xml file from internet" do
    macbeth_xml = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
    doc1 = Nokogiri::XML(open(macbeth_xml))
    analyzer = ShakespeareAnalyzer.new(doc1)
    result = analyzer.analyze
    expect(result).to eq({"First Witch"=>62, "Second Witch"=>27, "Third Witch"=>27, "ALL"=>24, "DUNCAN"=>70, "MALCOLM"=>212, "Sergeant"=>35, "LENNOX"=>73, "ROSS"=>135, "MACBETH"=>718, "BANQUO"=>113, "ANGUS"=>21, "LADY MACBETH"=>265, "Messenger"=>23, "FLEANCE"=>2, "Porter"=>46, "MACDUFF"=>180, "MACBETHLENNOX"=>1, "DONALBAIN"=>10, "Old Man"=>11, "ATTENDANT"=>1, "First Murderer"=>30, "Second Murderer"=>15, "Both Murderers"=>2, "Servant"=>5, "Third Murderer"=>8, "Lords"=>3, "HECATE"=>39, "Lord"=>21, "First Apparition"=>2, "Second Apparition"=>4, "Third Apparition"=>5, "LADY MACDUFF"=>41, "Son"=>20, "Doctor"=>45, "Gentlewoman"=>23, "MENTEITH"=>12, "CAITHNESS"=>11, "SEYTON"=>5, "SIWARD"=>30, "Soldiers"=>1, "YOUNG SIWARD"=>7})
  end
  
end