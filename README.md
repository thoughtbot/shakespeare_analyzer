# Thoughtbot (Now Upcase) Shakespeare Analizer

## Directions

Take the following XML file: (http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml)[Macbeth XML]

Write Ruby code to parse the xml and extract the speakers and their line counts.

## My solution

In the ./bin folder you will find 2 executable files that implement my solution. One prints out to a screen, the other saves the file to the hard disk as output.txt You could, for instance, write one that saves to a database or whatever floats your boat, all without editing the original software in lib. Al la, the Open/Closed principle bitches.

## Running my solution

to print the output to screen:

```bash
bundle
./bin/print
```

or to save the output:

```bash
bundle
./bin/save
```
