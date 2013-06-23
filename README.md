MBSwitch
========

MBSwitch is an iOS style UISwitch working with iOS < 7<br />
You couls set the 'onTintColor', 'offTintColor' and the 'thumbTintColor' of your choice.<br />
It works with iPhone, iPod Touch or iPad, with retina display or not.<br />

<img width=580 src="https://raw.github.com/mattlawer/MBSwitch/master/README/anim.gif"/>


Usage
-----

1) Create the MBSwitch with default size 51x31.

	MBSwitch *_mbswitch2 = [[MBSwitch alloc] initWithFrame:CGRectMake(20.0, 129.0, 51.0, 31.0)];
    

2) Customize the appearance
	
    [_mbswitch2 setOnTintColor:[UIColor colorWithRed:0.23f green:0.35f blue:0.60f alpha:1.00f]];
    [_mbswitch2 setOffTintColor:[UIColor colorWithRed:0.91f green:0.30f blue:0.24f alpha:1.00f]];
    [_mbswitch3 setThumbTintColor:[UIColor grayColor]];

3) Add the MBSwith to your view 
	
	[self.view addSubview:_mbswitch2];
    
    
Example
-------

With some colors

<img width=147 src="https://raw.github.com/mattlawer/MBSwitch/master/README/example.gif"/>
<img width=147 src="https://raw.github.com/mattlawer/MBSwitch/master/README/tint_example.gif"/>
<img width=147 src="https://raw.github.com/mattlawer/MBSwitch/master/README/tint_example2.gif"/>

    
License
-------

Copyright (c) 2012, Mathieu Bolard
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

* Neither the name of Mathieu Bolard, mattlawer nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Mathieu Bolard BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Contact
-------

mattlawer08@gmail.com<br />
http://mathieubolard.com<br />
http://twitter.com/mattlawer
