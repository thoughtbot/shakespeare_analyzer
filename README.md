# Upcase Analyzing Shakespeare 

## Directions

Take the following XML file: [Macbeth XML](http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml)

Write Ruby code to parse the xml and extract the speakers and their line counts.

The main entry-point is the lib/shakespeare_analyzer.rb and it is a stand-alone module, which means it holds no state and it is _not_ meant to be *mixed in*.

## Running the tests

```bash
rake
```

Nothing more. You might need to `bundle install` frst.

The tests that are here are very basic top level tests. They are meant to be acceptance tests, meaning when the code 'works' these tests will pass without you changing them at'tall, as my English friend says.

## How about some help asshole?

Well, sure. That is only fair. If I gave you no further help I wouldn't be much of a RubyMentor, and that is exactly what I have become and am happy to be. So.......

## TDDing the Shakespeare Analyzer

I do this kind of thing much better in video than I do in text. Maybe it is because I curse less in video... Probably not, I think it may just be because I am really too lazy for my own good. Bullshit. I am a good programmer because I am just lazy enough!

Watch the [RubyLIVE.tv episode here](https://www.youtube.com/watch?v=lBkau5T1KnA)

And the code is in [this branch](https://github.com/therubymentor/shakespeare_analyzer/tree/420-live)

## My solution

Located [in this branch](https://github.com/therubymentor/shakespeare_analyzer/tree/jimokelly-solution)

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

