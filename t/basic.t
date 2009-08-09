use strict;
use warnings;
use Test::More;

my $called = 0;

{
    package Foo;

    use Moose;
    use MooseX::MultiBuilder;

    has [qw/foo bar baz/] => (
        traits  => ['MultiBuilder'],
        is      => 'ro',
        builder => '_build_stuff',
    );

    sub _build_stuff {
        $called++;
        return {
            foo => 'affe',
            bar => 'tiger',
            baz => 'zomtec',
        };
    }
}

my $foo = Foo->new;
is($foo->foo, 'affe');
is($foo->bar, 'tiger');
is($foo->baz, 'zomtec');

is($called, 1, 'builder called once for all attrs');

done_testing;
