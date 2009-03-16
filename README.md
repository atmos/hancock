hancock
=======

It's like your [John Hancock][johnhancock] for all of your company's apps.  

A lot of this is extracted from our internal single sign on server at [Engine Yard][ey].  We
use a different [datamapper][datamapper] backend but it should be a decent
start for most people.

Features
========
An [OpenID][openid] based [Single Sign On][sso] server that provides:

* a single authoritative source for user authentication
* a [whitelist][whitelist] for consumer applications
* integration with the big ruby frameworks via [rack][hancock_examples].
* configurable [sreg][sreg] parameters to consumers

How it Works
============
![SSO Handshake](http://img.skitch.com/20090305-be6wwmbc4gfsi9euy3w7np31mm.jpg)

This handshake seems kind of complex but it only happens when you need to
validate a user session on the consumer.

Installation
============
    % gem sources
    *** CURRENT SOURCES ***

    http://gems.rubyforge.org/
    http://gems.engineyard.com
    http://gems.github.com

You need a few gems to function

    % sudo gem install dm-core do_sqlite3
    % sudo gem install sinatra guid rspec ruby-openid

You need a few more to test, including [sr][sr]'s [fork][srfork] of [webrat][webrat]
    % sudo gem install selenium-client rspec
    % git clone git://github.com/sr/webrat.git
    % cd webrat
    % git checkout -b sinatra origin/sinatra
    % rake repackage
    % sudo gem uninstall -aI webrat
    % sudo gem install pkg/webrat-0.4.2.gem

Plans
=====
* signup with email based validation
* single sign off
* some kinda awesome [oauth][oauth] hooks
* [simpledb][simpledb] integration, srsly

Sponsored By
============
* [Engine Yard][ey]

[johnhancock]: http://www.urbandictionary.com/define.php?term=john+hancock
[ey]: http://www.engineyard.com/
[sr]: http://github.com/sr
[atmos]: http://github.com/atmos
[halorgium]: http://github.com/halorgium
[adelcambre]: http://github.com/adelcambre
[srfork]: http://github.com/sr/webrat/tree/sinatra
[webrat]: http://github.com/brynary/webrat
[hancock_examples]: http://github.com/atmos/hancock-client/tree/98aae96077a8fbfa0097f33ec3ecd628fc549c54/examples/dragon
[datamapper]: http://datamapper.org
[openid]: http://openid.net/
[sso]: http://en.wikipedia.org/wiki/Single_sign-on
[whitelist]: http://en.wikipedia.org/wiki/Whitelist
[oauth]: http://oauth.net/
[sreg]: http://openid.net/specs/openid-simple-registration-extension-1_0.html#response_format
[simpledb]: http://aws.amazon.com/simpledb/
