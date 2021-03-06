
s.boot;


~bufPianoSwells = Buffer.read(s, "/Users/matthewhinea/supercollider/Piano Swells.aif");

~uGenSelect = Bus.control(s, 2);
~uGenSelect.set(1);

(
SynthDef(\test_BufRd2,
	{
		arg trig = 0, rate = 1, mul = 1;
		var out, env, a, cycle, bufnum, levels, times, select, selectTrig;
		bufnum = ~bufPianoSwells.bufnum;

		a = [Line.ar(1,1,inf,1),
			Line.ar(1,1,inf,1)
			* LFNoise0.ar( //change rate
				LFNoise0.ar( //change rate of rate of change
					LFNoise1.kr(18), //change rate of rate of change of rate of change
					3, 6),
				1, 0.8)
			+ WhiteNoise.ar(0.3) //static effect
		];
		cycle = a.size * 0.5;
		cycle.postln;
		select = LFSaw.kr(1.0,1.0,cycle,cycle).scope;
		//select = In.kr(~uGenSelect); //for MIDI interaction

		out = BufRd.ar(
			2,
			bufnum,
			Phasor.ar(trig,
				BufRateScale.kr(bufnum) * Select.ar(select, a) * rate,
				0,
				BufFrames.kr(bufnum)- 2
			)
		);
	
		env = 1; 
		out = out * env * mul;
		Out.ar(0, out);
}).add
)


~bufPsychSynth = Synth(\test_BufRd2);



{LFSaw.kr(1.0,0.0,1,1)}.plot(10);

//alternate envelopes:
/*
Env.new(
					[0, 3, 0.2, 2, 1.8, 1.95, 1.7, 2.6, 0.4, 2],
					[0.0755/2, 0.12, 0.15, 0.16, 0.167, 0.169, 0.174, 0.19, 0.225],
					curve: \lin
				)



Env.new(
					[0, 2.5, 2.5, 0.9, 0.9, 1.9, 1.9, 1.85, 1.85, 2.1, 2.1, 1.95, 1.95, 2.4, 2.4, 2.25, 2.25, 1.3, 1.3, 2],
					[1e-4, 0.125, 1e-4, 0.25, 1e-4, 0.07, 1e-4, 0.03, 1e-4, 0.02, 1e-4, 0.1, 1e-4, 0.075, 1e-4, 0.05, 1e-4, 0.25]
				)
*/







(
SynthDef("help-Select",{ arg out=0;

    var a,cycle;
    a = [
            SinOsc.ar,
            Saw.ar,
            Pulse.ar
        ];
    cycle = a.size  * 0.5;
    Out.ar(out,
        Select.ar(LFSaw.kr(1.0,0.0,cycle,cycle),a) * 0.2
    )
}).play;

)





MIDIClient.init;
MIDIIn.connectAll;


(
MIDIdef.cc(\uGenSelector, {
	arg val, num, chan, src;
	[val, num, chan, src].postln; //a good freqshift value is ~0.62
	~uGenSelect.set(val.linlin(0, 127, 0, 1)); //synths we want to affect read in from
}, 22).permanent_(true);
)
