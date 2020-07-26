# A Simple High Throughput Result Declaration System

This is an ongoing project. Feel free to pitch in with other framework implementations!

I was reminded a couple days ago just how ridiculously horrible the systems that multiple organisations like CBSE and JEE use to show their results are when my cousins had to wait for hours on end to see their results, constantly redirected to unhelpful 500 pages.

I wonder if I can make a system which can do a much better job at this.
To do this, I'll follow the following phases.

1. I'll figure out the goals and requirements of the project.
2. I'll implement the backend in fastify, so as to set a baseline as well as a "ground truth implementation."
3. I'll implement the backend in a couple frameworks (which I'm lazily choosing by writing simple json response api's in a bunch of them and choosing from there, more below.)
4. ???
5. Profit (?)

## An experiment on backend frameworks

An initial point of discussion was picking which frameworks to test. The easiest way I could think of for doing this was simply to try writing a simple plaintext response with a bunch of languages and see where it goes from there.

To test initially, we picked:
* Flask/Python, as it is a common choice for backend servers, especially in ML circles.
* Falcon/Python, as it is often used as a faster replacement to Flask
* FastAPI/Python, as it is a new "fast python web framework."
* Express/NodeJS, as it is a common choice for node backend servers.
* Fastify/NodeJS, as it is a faster alternative to the above.
* Gin/Go, as it is a fast framework in a language meant for these kind of servers.
* Actix/Rust, as it is purpose built to be a blazingly fast web server.
* Kemal/Crystal, as I thought it was cool

The benchmark itself was a simple load test where the client would load the / path and wait between 0 and 1 seconds. The benchmark was run on locust, running is a master-slave configuration on my local machine, with 7 workers. Find the locustfile in the tests/plaintext directory.

The test was conducted with a constant spawn rate of 700 (100 per worker), spawing a total of 700, 7000, and 14000 users. The test was run until the responses stabilized or until 100,000 requests, whichever is earlier, and then the stablised requests per second and number of failures were collected. The results are:

### 700 Users
Framework | Mean Time    | % Failures 
----------|--------|---------------
 Flask    | 4ms/1380RPS  | 0%
 Falcon   | 4ms/1400RPS  | 0%
 FastAPI  | 4ms/1396RPS  | 0%
 Express  | 2ms/1390RPS | 0%
 Fastify  | 2ms/1390RPS | 0%
 Gin      | 2ms/1400RPS | 0%
 Actix    | 2ms/1390RPS | 0%
 Kemal    | 2ms/1390RPS | 0%


### 7000 Users
Framework | Mean Time    | Num Failures 
----------|--------|---------------
 Flask    | 2921 | 0.4%     
 Falcon   | 2359 | 0%      
 FastAPI  | 2212 | 0%
 Express  | 736 | 0%
 Fastify  | 662 | 0%
 Gin      | 598 | 0%
 Actix    | 728 | 0%
 Kemal    | 570 | 0%

### 14000 Users

Framework | Mean Time    | Num Failures 
----------|--------|---------------
 Flask    | 4486 | 1%
 Falcon   | 3418 | 0.05%
 FastAPI  | 3962 | 0%
 Express  | 1794 | 0%
 Fastify  | 1644 | 0%
 Gin      | 1657 | 0%
 Actix    | 1552 | 0%
 Kemal    | 1507 | 0%

### Development Experience

I won't be using either Kemal or Actix, simply because it's far too close to the metal. You have to worry about a lot of low level implementation detail, which isn't bad, but it's not what I'm after with this. I also don't think I'll have the knowhow required in order to actually write optimal code in either of these.

Go was actually surprisingly easy to code in.

The JS and Python frameworks are as expected--simple, usable, and really well documented. I faced no problem with any of them.

### Takeaways

I strongly believe that my testing system with locust was subpar. I'll have to investigate other testing frameworks and find out what works for me. Fortunately, there's no better place to do that than with projects like there haha.

The most surprising result here were of the node frameworks. They're much faster than I expected, able to keep pace with Go/Rust/Crystal. I didn't expect that kind of performance from them, to be honest.

While I planned to implement the ground truth implementation in Flask, I'm going to switch to NodeJS now. The python applications were the only ones to actually drop requests, and performed worse and less consistently than any of the other frameworks. I don't see a point in continuing to use them at this stage.

I'll continue developing, for now, in only fastify as well as go. However, I'll switch to using go with Fiber instead of Gin, since Gin doesn't seem to be as performant in online benchmarks, although the difference is minute in my own benchmark

Framework | Mean (7000) | Mean (14000)
----------|-------------|-------------
 Gin | 598 | 1657 
 Fiber | 596 | 1467

The plan is thus to implement the system in Fastify, and then follow up with Fiber/Go. Also, look into other possible load testing systems.