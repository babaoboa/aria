# Entry 1 - What is Aria, what do I want from it and the architecture
## Oct 2, 2026

First Journal entry!

Let's get into it.

#### What is Aria?
Aria in short is a blazingly fast and beautifull vex robotics library. It's aim is to allow everyone, and I mean *everyone*, Aria should be super easy to use by everyone, it should also be as competent and advanced as a tradional production autonomous library. It's also built as a tool for us (team 2381) to build world class autonomous routines.

#### Nice, but what does it do?
Aria should have all the functions to control a vex robot. This can be as simple as turning a wheels a certain amount, to as complex as sensor fusion algorithms like Monte-Carlo.

Aria will be built in c++, using pros for a hardware interface, and lvgl for rendering things on the Vex Brain screen. 

#### Identify

Last year, our team (2381) participated in the vex pushback competition. Making autonomous routines is a big part of the game, and can turn the direction of the game around before it even starts. Last year we tried using open source libraries like EZ and LemLib but we always saw something lacking within them. They weren't really built for the new age of engineering, lacking features, and built a long time ago (and also of course so we could have fun ;-)). Let's plan out the features!

#### Features

We've seperated the robot into three simple layers which our library would be targeting. Subsystems, Directional, and something we call "The Front".

#### Subsystems

Let's start with the Subsystems. This is the part of the robot that interacts with game elements to either, play the game, or help other parts play the game. This includes things like motors, distance-sensors, etc. This part of the library will mostly operate through the pros api, which we're using to speak to hardware. In the future we'd love to replace pros with our own solution, especially because it's written in python, and doesn't really give us direct access to subsystems.

#### Directional

This is one of the main parts of any vex robotics library, since movement is quite important to the game. This will include the core algorithms, like pure pursuit (and boomerang) to translate co-ordinates into instructions the motors can follow.

#### The front

This is the thing everyone touches, the user facing api like moving chasses with commands, this is what we aim to make perfect. This also includes the brain screen, an auton selector, a live odomtry view of sensor readouts and an on brain PID-Tuner. Driver control also fits into here with controll mappings, macros and advanced features like drive curves.

