#ifndef THERMISTORTABLE_H_
#define THERMISTORTABLE_H_

// How accurately do we maintain the temperature?
#define HALF_DEAD_ZONE 5

#if MOTHERBOARD < 2

// Uncomment the next line if you are using a thermistor; leave it if you have a thermocouple
#define USE_THERMISTOR

// How many temperature samples to take for an average.  each sample takes about 100 usecs.
#define TEMPERATURE_SAMPLES 3

#endif

// Thermistor lookup table for RepRap Temperature Sensor Boards (http://make.rrrf.org/ts)
// See this page:  
// http://dev.www.reprap.org/bin/view/Main/Thermistor
// for details of what goes in this table.
// Made with createTemperatureLookup.py (http://svn.reprap.org/trunk/reprap/firmware/Arduino/utilities/createTemperatureLookup.py)
// ./createTemperatureLookup.py --r0=100000 --t0=25 --r1=0 --r2=4700 --beta=4066 --max-adc=1023
// r0: 100000
// t0: 25
// r1: 0
// r2: 4700
// beta: 4066
// max adc: 1023
#ifdef USE_THERMISTOR
#define NUMTEMPS 20
short temptable[NUMTEMPS][2] = {
   {1, 905},
   {54, 263},
   {107, 215},
   {160, 188},
   {213, 170},
   {266, 157},
   {319, 145},
   {372, 135},
   {425, 126},
   {478, 118},
   {531, 110},
   {584, 103},
   {637, 95},
   {690, 87},
   {743, 80},
   {796, 71},
   {849, 62},
   {902, 50},
   {955, 34},
   {1008, 2}
};

#endif
#endif

