# A2SERVER
AppleTalk server for Apple // computers developed by Ivan Drucker, with
substantial rework and by T. Joseph Carter

Documentation here is sparse for the moment; see [Ivan's site]() for
information about A2SERVER and how it all works.  There's a lot there and it's
kind of evolved organically over the years just as the scripts themselves
have, so it's going to be awhile before that information can be backfilled and
perhaps organized into something you might call a user manual.

Such a manual should not be considered a replacement for Ivan's organic online
documentation--those contents themselves represent Apple // history, if a
relatively modern piece of it.  As such they should be preserved as they are.

## Developer note

To use the scripts with a specific GitHub tag:
~~~ bash
export A2SERVER_SCRIPT_URL=https://raw.githubusercontent.com/NJRoadfan/a2server/TAG_GOES_HERE/
export A2SERVER_BINARY_URL=${A2SERVER_SCRIPT_URL}files
wget -O setup ${A2SERVER_SCRIPT_URL}setup/index.txt; source setup
~~~

Or, to use the scripts on your own server, including your local machine:

~~~ bash
export A2SERVER_SCRIPT_URL=http://yoururl.com/
~~~

To prevent needing to recompile various packages from source code during
installation, a number of precompiled binary files are downloaded for Raspbian,
Debian-x86, and Debian-amd64. If you wish to host these on your own server:

~~~ bash
export A2SERVER_BINARY_URL=http://yoururl.com/files/
~~~

You do not need to use a subdirectory called "files", or the same server, but
that's the normal arrangement. The precompiled packages are available here:
`http://ivanx.com/a2server/files/dist/a2serverbinaries.tar.gz`

Several Apple II third-party binaries are downloaded during installation, as
well as third-party source code if precompiled binaries are unavailable or
you don't wish to use them. If you want these external dependencies locally
during development, they need to go into a folder called "external" in
the binaries URL, and that needs to contain folders called "appleii" and
"source". To download all of these external packages, download and run the
shell script at
`http://ivanx.com/a2server/files/dist/getexternal.sh`.

Once you have those:

~~~ bash
export A2SERVER_NO_EXTERNAL=1
~~~

You may want to put the above exports into `~/.bashrc` or `~/.bash_profile`.

If you want to host scripts locally installed on your own machine or another
computer on your LAN, type the following, and export "http://localhost:8000/"
or "http://lan.ip.address:8000/" for the above URL's.

~~~
python -m SimpleHTTPServer
~~~

Once you're set, you can then run the following snippet to install A2SERVER:

~~~
wget -O setup ${A2SERVER_SCRIPT_URL}setup/index.txt; source setup
~~~


Offline install:

Offline installs are no longer supported with A2SERVER 2.x.

[Ivan's site]: http://appleii.ivanx.com/a2server/
