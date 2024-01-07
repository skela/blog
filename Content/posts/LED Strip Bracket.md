---
date: 2024-01-07 21:17
description: Attaching my new LED strip.
id: LED Strip Bracket
tags: openscad, diy
---

Needed a way to attach a LED strip I bought from [AliExpress](https://www.aliexpress.com/item/1005003213415540.html) to a surface.
The dimensions of this particular strip were 11.8mm by 6mm.
So [OpenSCAD](https://openscad.org/) to the rescue. Made a simple cube, cut out a channel and added a screw hole.

![OpenSCAD Model](/res/led_strip_bracket.png)

Making the most of my Ender 5 Pro build plate, with a sequential print, 9 brackets at a time.

![Sequential Print](/res/led_strip_bracket-sequential_print.png)

```
led_thickness = 11.8;
led_height = 6;

bw = 20; // bracket width
bt = 2; // bracket thickness
lfh = led_height + 0.2; // channel height to fit the led strip
bd = 12; // bracket depth, needs to be bigger than led thickness

$fn=1000;

module bracket()
{
    difference()
    {
        cube([bw,lfh+bt,bd],center=true);
        translate([0,0,bt])
        {
            cube([bw+bt,lfh,bd+bt],center=true);
        }
    }
}

difference()
{
    bracket();
    translate([0,0,-5]) { cylinder(h=bt/2,r=2.4,center=true); }
    translate([0,0,-5]) { cylinder(h=bt*2,r=1,center=true); }
}
```
