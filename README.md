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

Features
========
An OpenID based Single Sign On server that provides:

* a whitelist for consumers
* minimal setup to integrate with consumers(rails,merb,sinatra)
* simple sreg parameters to consumers(first name, last name, email, identity_url)

How it Works
============
![SSO Handshake](http://img.skitch.com/20090305-be6wwmbc4gfsi9euy3w7np31mm.jpg)

Plans
=====
* signup with email based validation
* some kinda awesome oauth hooks
* simpledb integration, srsly

Thanks
======
Thanks to [Engine Yard][ey] who paid Tim and I to write something like this for work.

[johnhancock]: http://www.urbandictionary.com/define.php?term=john+hancock
[ey]: http://www.engineyard.com/
[sr]: http://github.com/sr
[srfork]: http://github.com/sr/webrat/tree/sinatra
[webrat]: http://github.com/brynary/webrat
