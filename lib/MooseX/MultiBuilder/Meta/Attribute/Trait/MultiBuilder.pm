package MooseX::MultiBuilder::Meta::Attribute::Trait::MultiBuilder;

use Moose::Role;
use namespace::autoclean;

after _process_options => sub {
    my ($class, $name, $options) = @_;

    $class->throw_error("You cannot have a MultiBuilder attribute ($name) without a builder", data => $options)
        unless exists $options->{builder};

    my $multi_builder = delete $options->{builder};
    my $multi_builder_result;

    $options->{default} = sub {
        my $self = shift;

        if (!$multi_builder_result) {
            $multi_builder_result = $self->$multi_builder;
            confess "MultiBuilder didn't return a hash reference for attribute $name"
                unless ref $multi_builder_result eq 'HASH';
            confess "MultiBuilder didn't return a result for attribute $name"
                unless exists $multi_builder_result->{$name};
        }

        return $multi_builder_result->{$name};
    };

    return;
};

package # hide
    Moose::Meta::Attribute::Custom::Trait::MultiBuilder;

sub register_implementation { 'MooseX::MultiBuilder::Meta::Attribute::Trait::MultiBuilder' }

1;
