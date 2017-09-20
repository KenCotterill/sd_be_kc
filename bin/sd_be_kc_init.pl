#!perl

use strict;
use warnings;
use autodie;

use Storable;

use constant {
    WORDS_FILENAME    => '../dict/lc_words',
    STORABLE_FILENAME => '../dict/words.sto',
};

my $dict_hash = {};

{
    open my $fh, '<', WORDS_FILENAME;

    while (<$fh>) {
        chomp;
        my $word = $_;
        my @chars = split '', $word;
        my $ref = $dict_hash;

        for my $char (@chars) {
            $ref->{$char} = {} unless exists $ref->{$char};
            $ref = $ref->{$char};
        }

        $ref->{'='} = $word;
    }
}

store $dict_hash, STORABLE_FILENAME;

