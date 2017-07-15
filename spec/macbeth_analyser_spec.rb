require_relative './spec_helper'
require_relative '../macbeth_analyzer'
require 'pry'
require 'nokogiri'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)


PROPHACY = Nokogiri::XML::Document.parse(File.open( "./spec/play.xml" ))


describe MacbethAnalyzer do

  it 'parses a script to count the speaking parts' do
    expect(MacbethAnalyzer.new(script: PROPHACY).report).to be_a(String)
  end

  it 'removes all from list' do
    expect(MacbethAnalyzer.new(script: PROPHACY).report).to_not match( /all/i)
  end
end


PROPHACY = "
<PLAY>
    <TITLE>The Tragedy of Macbeth</TITLE>
    <ACT>
        <SCENE>
            <SPEECH>
                <SPEAKER>Second Witch</SPEAKER>
                <LINE>By the pricking of my thumbs,</LINE>
                <LINE>Something wicked this way comes.</LINE>
                <LINE>Open, locks,</LINE>
                <LINE>Whoever knocks!</LINE>
            </SPEECH>
            <STAGEDIR>Enter MACBETH</STAGEDIR>
            <SPEECH>
                <SPEAKER>MACBETH</SPEAKER>
                <LINE>How now, you secret, black, and midnight hags!</LINE>
                <LINE>What is't you do?</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>ALL</SPEAKER>
                <LINE>A deed without a name.</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>MACBETH</SPEAKER>
                <LINE>I conjure you, by that which you profess,</LINE>
                <LINE>Howe'er you come to know it, answer me:</LINE>
                <LINE>Though you untie the winds and let them fight</LINE>
                <LINE>Against the churches; though the yesty waves</LINE>
                <LINE>Confound and swallow navigation up;</LINE>
                <LINE>Though bladed corn be lodged and trees blown down;</LINE>
                <LINE>Though castles topple on their warders' heads;</LINE>
                <LINE>Though palaces and pyramids do slope</LINE>
                <LINE>
                    Their heads to their foundations; though the treasure
                </LINE>
                <LINE>Of nature's germens tumble all together,</LINE>
                <LINE>Even till destruction sicken; answer me</LINE>
                <LINE>To what I ask you.</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>First Witch</SPEAKER>
                <LINE>Speak.</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>Second Witch</SPEAKER>
                <LINE>Demand.</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>Third Witch</SPEAKER>
                <LINE>We'll answer.</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>First Witch</SPEAKER>
                <LINE>Say, if thou'dst rather hear it from our mouths,</LINE>
                <LINE>Or from our masters?</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>MACBETH</SPEAKER>
                <LINE>Call 'em; let me see 'em.</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>First Witch</SPEAKER>
                <LINE>Pour in sow's blood, that hath eaten</LINE>
                <LINE>Her nine farrow; grease that's sweaten</LINE>
                <LINE>From the murderer's gibbet throw</LINE>
                <LINE>Into the flame.</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>ALL</SPEAKER>
                <LINE>Come, high or low;</LINE>
                <LINE>Thyself and office deftly show!</LINE>
            </SPEECH>
            <STAGEDIR>Thunder. First Apparition: an armed Head</STAGEDIR>
            <SPEECH>
                <SPEAKER>MACBETH</SPEAKER>
                <LINE>Tell me, thou unknown power,--</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>First Witch</SPEAKER>
                <LINE>He knows thy thought:</LINE>
                <LINE>Hear his speech, but say thou nought.</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>First Apparition</SPEAKER>
                <LINE>Macbeth! Macbeth! Macbeth! beware Macduff;</LINE>
                <LINE>Beware the thane of Fife. Dismiss me. Enough.</LINE>
            </SPEECH>
        </SCENE>
    </ACT>
</PLAY>
"