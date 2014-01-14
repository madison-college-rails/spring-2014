# Week 1

* Introductions
* Review syllabus
* Resources
* Install fest

## Ubuntu VM

1.  Install the needed postgres packages:

        $ sudo apt-get install \
          postgresql \
          postgresql-9.1 \
          postgresql-client-9.1 \
          postgresql-client-common \
          postgresql-common \
          postgresql-server-dev-9.1

2.  Verify:

        $ dpkg --get-selections | grep -v deinstall | grep postgres

    Expected output:

        postgresql                   install
        postgresql-9.1               install
        postgresql-client-9.1        install
        postgresql-client-common     install
        postgresql-common            install
        postgresql-server-dev-9.1    install

3.  Make sure the *student* account is a Postgres superuser:

        $ sudo -u postgres createuser -s student

4.  Make sure postgres is running:

        $ psql -c "select table_name from information_schema.tables" template1 | wc -l

    Expected output:

        158 # or some number

5.  Update rvm:

        $ rvm get head

6.  Make sure ruby-2.0.0-p353 is known:

        $ rvm list known | grep 353

    Expected output:

        [ruby-]2.0.0[-p353]

7.  Install it:

        $ rvm install 2.0.0-p353

8.  Verify that p353 is in the list here:

        $ rvm list

9.  Install nodejs:

        $ sudo apt-get install nodejs

10. Make sure rvm is a function:

        $ type rvm

    Expected output:

        rvm is a shell function

    You may need to do follow [these instructions](http://rvm.io/integration/gnome-terminal)

## Mac OS X Mavericks

1.  Install XCode and the command line utils

2.  Verify:

        $ xcode-select -p

    Expected output:

        /Applications/Xcode.app/Contents/Developer

    Make sure you have gcc:

        $ gcc --version

    Expected output:

        Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
        Apple LLVM version 5.0 (clang-500.2.79) (based on LLVM 3.3svn)
        Target: x86_64-apple-darwin13.0.0

3.  Is brew installed?

        $ which brew

    If that says "brew not found", then install homebrew using the command here http://brew.sh/

4.  Install postgres

        $ brew install postgres

5.  Start postgres running in the background:

        $ pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start

6.  [Install rvm](https://rvm.io/rvm/install)

7.  Make sure that /usr/local/bin is first on the PATH by editing ~/.bashrc you may see something like this:

        export PATH=stuff

    You want to edit that to put /usr/local/bin in before whatever is already there:

        export PATH=/usr/local/bin:stuff

    "stuff" is just intended to represent whatever is currently there.

    After you save this file, to make it take effect, close and restart your Terminal.

8.  Verify:

        $ which psql

    Expected output:

        /usr/local/bin/psql

## Other Gotchas

1.  Edit ~/.gemrc to skip generating documentation when installing gems

        gem: --no-ri --no-rdoc

## Sample Rails App

If you've followed the above, you should be able to create a sample Rails app:

1.  Setup a gemset:

        $ rvm use ruby-2.0.0-p353@sample --create

2.  Install rails in this gemset:

        $ gem install rails

3.  Create the app using postgresql as the database:

        $ rails new sample -d postgresql

4.  Create the sample user as a superuser with a known password:

        $ createuser -s -P sample

    For Ubuntu, you'll need to set `host` and `password` properties in the
    `development` and `test` sections of `config/database.yml`:

        development:
          adapter: postgresql
          encoding: unicode
          database: sample_development
          pool: 5
          username: sample
          password: sample
          host: localhost

       test:
          adapter: postgresql
          encoding: unicode
          database: sample_test
          pool: 5
          username: sample
          password: sample
          host: localhost

5.  Change to the sample folder:

        $ cd sample

6.  Create the databases for the app:

        $ rake db:create

7.  Run the server:

        $ rails server

8.  Navigate to http://localhost:3000 and verify you can see "Welcome aboard"

## Homework

Your homework for the first class is to send me a screenshot of your "Welcome aboard" page.

