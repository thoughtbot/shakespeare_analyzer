## Shakespeare Analyzer

The Shakespeare Analyzer downloads and parses the XML-encoded version of Macbeth, found here: http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml

Sample usage/output (using made-up numbers):

    $ ruby macbeth_analyzer.rb
      543 Macbeth
      345 Banquo
      220 Duncan
      (etc.)

## TODO
  + Find a way to attribute lines for "ALL" to each speaker on the stage.