First of all I would like to say that I am not a fan of the way the Github Archive service is implimented. Bulk functions don't work. Even using curl or wget with the exact same examples the auther uses. The wrong status codes are sent when things fail. There are no helpful error message. 2/10 would not use again.

Answers to "Going Further"
==========================
1. There are 18 published Event Types. How would you manage them? What would you do if GitHub added more Event Types?

Implimented matching of types based on a constant array literal. Implimention follows The Open Closed Pricipal. The behavior is easily open to extension; Just add or remove event types from the array. But the code itself shouldn't need to be changed in the future; It is closed to modification.

****************************************************
2. What factors impact performance? What would you do to improve them?

The main factor in performane is getting the ~10MB files from the service. Ideally the service would support a way to fetch multiple files in bulk over one connection. If the data doesn't change and the program was to used with high frequency, then it would be worth it to grab all the files and pop them into a local database to speed things up.

It's also possible to cache the files that get loaded locally. Adhoc as needed to speed things up slightly over time.

****************************************************
3. The example shows one type of output report. How would you add additional reporting formats?

Additional reporting formats could easily be handled by implimenting a strategy or factory design pattern. There is a common interface for the reports. They all take the same inputs and produce the same output. I implimented a shell for the factory pattern to demonstrate the concept.

****************************************************
4. If you had to implement this using only one gem, which would it be? Why?

You don't need any 3rd party gems to do this.
The only real ruby lib gem that you need is http. Json is easy enough to parse. Gzip can be done on the wire. Other gems are used just to make things easier/cleaner.