# hoboken-piano
Code for glitching audio files in a realisting way. The LFNoise oscillators in the "a" variable generate the meat of the algorithm, which is then multiplied by a simple linear rate to rapidly alter the frames per second of the sample. The "scope" method is called on the result so you can see the algorithm as it works.  Googling to find code to get the effect I wanted got me no where, so this is my original solution. The two files on this repository are included so the curious programmer may choose to connect their own MIDI device for enhanced control over the glitch algorithm, or simply let the algorithm work on its own.

* Listen to the result [here](https://soundcloud.com/hatredofmusic/piano-swells-glitched).
* See my other work in Supercollider [here](https://github.com/mnd-dsgn/red_sun).
* [Supercollider](http://supercollider.github.io/download.html) is a dynamically typed, garbage-collected, single inheritance object-oriented and functional language similar to Smalltalk with syntax similar to Lisp or the C programming language.
