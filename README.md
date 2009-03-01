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
    % git clone git://github.com/sr/webrat.git

You need sr's fork of webrat for the time being

    % cd webrat
    % git checkout -b sinatra origin/sinatra
    % rake repackage
    % sudo gem uninstall -aI webrat
    % sudo gem install pkg/webrat-0.4.2.gem


Features
========
An OpenID based Single Sign On server that provides some stuff

* a whitelist for consumers
* signup with email based validation
* minimal setup to integrate with consumers(rails,merb,sinatra)
* simple sreg parameters to consumers(first name, last name, email, identity_url)

Plans
=====
* some kinda awesome oauth hooks
* simpledb integration, srsly

[johnhancock]: http://www.urbandictionary.com/define.php?term=john+hancock
