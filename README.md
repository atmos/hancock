hancock
=======

It's like your [John Hancock][johnhancock] for all of your company's apps.

Installation
============
    % gem sources
    *** CURRENT SOURCES ***

    http://gems.rubyforge.org/
    http://gems.engineyard.com
    http://gems.github.com

You need sinatra 0.9.1 or greater

    % sudo gem install sinatra-sinatra

You need sr's fork of webrat for the time being

    % git clone git://github.com/sr/webrat.git
    % cd webrat
    % git checkout -b sinatra origin/sinatra
    % rake repackage
    % sudo gem uninstall -aI webrat
    % sudo gem install pkg/webrat-0.4.2.gem
    % sudo gem install selenium-client

Features
========
An OpenID based Single Sign On server that provides some stuff

* a whitelist for consumers
* minimal setup to integrate with consumers(rails,merb,sinatra)
* simple sreg parameters to consumers(first name, last name, email, identity_url)

Plans
=====
* signup with email based validation
* some kinda awesome oauth hooks
* simpledb integration, srsly

Thanks
======
* [Engine Yard][ey]

[johnhancock]: http://www.urbandictionary.com/define.php?term=john+hancock
[ey]: http://www.engineyard.com/
