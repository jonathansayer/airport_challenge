Airport Challenge
=================

Introduction
---------
The Airport Challenge is a Challenge which is issued by Makers Academy at the end of Week 1. The aim of the Challenge is to test drive the development of a model of an Airport. The user Stories are as follows:

```
As a pilot
So that I can arrive at my specified destination
I would like to land my plane at the appropriate airport

As a pilot
So that I can set off for my specified destination
I would like to be able to take off from the appropriate airport

As an air traffic controller
So that I can avoid collisions
I want to be able to prevent airplanes landing when the airport if full

As an air traffic controller
So that I can avoid accidents
I want to be able to prevent airplanes landing when the weather is stormy
```

How I Tackled the Challenge
-------
The whole of this Program is written with Test Driven Methodology. The very first step was to write a test for the "main" class, which in this example was the airport. The test in this case is shown below:

![Alt text](/images/first_test.png?raw=true)

This test suite used for this particular example is Rspec. Once the test is failing for a right reasons (i.e not because of a syntax error in the test), the minimal amount of code is written in the airport class to pass the test. This process is repeated again. The User stories above drive the writing of the tests and the tests drive the writing of the code. Once the airport is complete, the same process was used to build the plane and weather classes.


Difficulties
-----

The biggest difficulty I had with the writing of the code came with the introduction of Stubbing. Stubbing is a method used to remove dependancies on outside classes when testing the class you are writing. For example when I was testing the airport class I didn't want a bug in my Plane class to be causing my airport tests to fail. To remove this dependancy we introduce a double to take the place of the plane.

![Alt text](/images/plane_double.png?raw=true)


This double behaves like the plane but only in the ways you explicitely state in the test. This means that the plane class is not involved when the test is running.

Stubbing tests was a new concept when writing this code base and one I had to learn myself in order to complete this challenge to the best of my ability.

How to use the Program
-----

In order to use the program the code base shoulf first either be cloned or pulled from the repository. This can be done by initialising git in a repository on your local machine. Run command line in a the desired repository and initialise git and clone this repo.

```
$ git init
$ git clone "https://github.com/jonathansayer/airport_challenge.git"
```

Once the repository has been cloned, change into the repo and run bundle to download the appropriate gems. The Run an interactive ruby environment such as irb or pry.

```
$ cd airport_challenge
$ bundle
$ irb
2.2.1 :001 > require './lib/airport.rb'
```

Now your ready to run the program. First initialise an airport and plane.

```
2.2.1 :002 > airport = Airport.new
2.2.1 :003 > plane = Plane.new
```

Planes are initialised flying (in the air), the following methods can now be used:

```
2.2.1 :004 > airport.land_plane plane  #lands a plane at the airport.
2.2.1 :005 > airport.planes  #returns all planes currently stored at the airport.
2.2.1 :006 > airport.capacity  #returns the capacity of the airport.(20)
2.2.1 :007 > airport.take_off  #releases the next plane in the order at the airport. The airport works on a first in first out basis.
```
On ocassion a storm may take hold making in impossible for an airport to take in any more planes

```
2.2.1 :008 > airport.land_plane plane
      => "The storm has made it impossible to land"  
```
If a storm is in town, planes cannot land or take off.
