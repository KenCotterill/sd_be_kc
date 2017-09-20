#!perl

use autodie;

use Algorithm::Permute 'permute';
use Mojolicious::Lite;
use Storable;

use constant STORABLE_FILENAME => '../dict/words.sto';
use constant ERR_INPUT => 'Invalid input: "%s". Only a-z allowed.';

get '/ping' => sub {
    shift->render(text => '200 OK');
};

get '/wordfinder/:input' => sub {
    my $c = shift;
    my $input = $c->param('input');

    if ($input =~ /^[a-z]+$/) {
        my $words = get_words($input);
        $c->render(json => $words);
    }
    else {
        $c->render(text => sprintf ERR_INPUT, $input);
    }
};

app->start;

sub get_words {
    my ($input) = @_;

    state $dict_hash = retrieve(STORABLE_FILENAME);

    my @chars = split '', $input;
    my %word;

    permute {
        my $ref = $dict_hash;

        for my $char (@chars) {
            next unless exists $ref->{$char};
            $word{$ref->{$char}{'='}} = 1 if exists $ref->{$char}{'='};
            $ref = $ref->{$char};
        }
    } @chars;

    return [ sort keys %word ];
}

