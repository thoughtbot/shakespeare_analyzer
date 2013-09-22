My attempt at the Thoughtbot Shakespear Analyser.

One tricky aspect would be how to handle lines which are spoken by multiple
characters at once. These are indicated in the text by `<SPEAKER>ALL</SPEAKER>`.

One way to accomplishe this would be with a Set tracking who is on stage:

  `<STAGEDIR>Enter ROSS</STAGEDIR>` - add Ross to the stage
  `<STAGEDIR>Exeunt</STAGEDIR>` - clear the set
  `<STAGEDIR>Enter the three Witches</STAGEDIR>` - remove each of the three witches from the set
  `<STAGEDIR>Exit Messenger</STAGEDIR>` - remove the Messenger from teh set

Then wherever there was a reference to `ALL`, we would read the set and increment
the line count for each of those characters.
