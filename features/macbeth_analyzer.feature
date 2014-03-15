Feature: ruby macbeth_analyzer.rb
  Scenario: print line counts
    Given a file named "a_few_lines.xml" with:
      """
      <ACT><TITLE>ACT I</TITLE>

      <SCENE><TITLE>SCENE I.  A desert place.</TITLE>
      <STAGEDIR>Thunder and lightning. Enter three Witches</STAGEDIR>

      <SPEECH>
      <SPEAKER>First Witch</SPEAKER>
      <LINE>When shall we three meet again</LINE>
      <LINE>In thunder, lightning, or in rain?</LINE>
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

      <SPEECH>
      <SPEAKER>First Witch</SPEAKER>
      <LINE>Where the place?</LINE>
      </SPEECH>
      </SCENE>
      </ACT>
      """
    When macbeth_analyzer is run with "a_few_lines.xml"
    Then it should pass with:
      """
      3 First Witch
      2 Second Witch
      1 Third Witch
      """
