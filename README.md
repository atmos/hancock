hancock
=======

It's like your [John Hancock][johnhancock] for all of your company's apps.  

A lot of this is extracted from our internal single sign on server at [Engine
Yard][ey].  We use a different [datamapper][datamapper] backend but it should
be a great start for most people.

Features
========
An [OpenID][openid] based [Single Sign On][sso] server that provides:

* a single source for user authentication using openid
* a [whitelist][whitelist] for consumer applications
* integration with the big ruby frameworks via [rack][hancock_examples].
* configurable [sreg][sreg] parameters to consumers

How it Works
============
![SSO Handshake](http://img.skitch.com/20090719-j3f895hp7h9dnkpjwc8ycqg29e.jpg)

This handshake seems kind of complex but it only happens when you need to
validate a user session on the consumer.

Testing/Developing Locally
==========================
You need the [Bundler][bundler] to function, and you MUST use the files
in bin/ for generated gem executables.

    % gem install bundler
    % bundle install
    % bundle exec rake

Deployment Setup
================

Ideally you just drop the middleware into your existing application.

TBD

Guidance
========
* http://openid.net/specs/openid-authentication-2_0.html
* http://wiki.openid.net/OpenID_Authentication_2.0
* http://jystewart.net/process/2007/10/a-ruby-on-rails-openid-server/
* http://lists.openidenabled.com/pipermail/dev/2007-March/000347.html

Feedback
========
* [Github Issues][githubissues]

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
[googlegroup]: http://groups.google.com/group/hancock-users
[githubissues]: http://github.com/atmos/hancock/issues
[bundler]: http://github.com/wycats/bundler
