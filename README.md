# sd_be_kc
Stategic Data - Coding task BE

This is the coding task described at: https://github.com/strategicdata/recruitment/wiki/Coding-task---BE

As per "Deliverables", I copied '/usr/share/dict/words'.
This contained many words with uppercase characters, so I removed those:

    $ perl -ne 'print if /^[a-z]+$/' words > lc_words

'lc_words' still contains many records which aren't really "words" (in the English language sense).
I've noted this but not made any attempts to make additional changes as that's not part of the task.

Reading the 'lc_words' file on every run seemed wasteful in terms of processing and time required.
This file is read only once as part of an initialisation procedure:

    $ perl sd_be_kc_init.pl

This creates 'words.sto' which is used by the web service.

The 'dict/' directory contains: 'words', 'lc_words' and 'words.sto'.

The code for the "small web service" is in 'sd_be_kc.pl'.

The 'bin/' directory contains: 'sd_be_kc.pl' and 'sd_be_kc_init.pl'.

The 'sd_be_kc.pl' script contains some minimal error checking.
More could be added: as before, not part of the task, so just noted at this point.

The web service is started like this:

    $ perl sd_be_kc.pl daemon -l http://*:8080
    [Wed Sep 20 17:10:40 2017] [info] Listening at "http://*:8080"
    Server available at http://127.0.0.1:8080

Some sample runs demonstrating the specified API:

    $ curl http://127.0.0.1:8080/ping
    200 OK

    $ curl http://127.0.0.1:8080/wordfinder/dgo
    ["d","do","dog","g","go","god","o","od"]

    $ curl http://127.0.0.1:8080/wordfinder/dGo
    Invalid input: "dGo". Only a-z allowed.

Modules Used:

* Algorithm::Permute - CPAN module: http://search.cpan.org/perldoc?Algorithm%3A%3APermute
* Mojolicious::Lite - CPAN module: http://search.cpan.org/perldoc?Mojolicious%3A%3ALite
* Storable - core module: http://perldoc.perl.org/Storable.html

(I don't have Docker available so that wasn't an option; otherwise, I would have tried it.)
