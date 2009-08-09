package MooseX::MultiBuilder::Meta::Attribute::Trait::MultiBuilder;

use Moose::Role;
use namespace::autoclean;

package # hide
    Moose::Meta::Attribute::Custom::Trait::MultiBuilder;

sub register_implementation { 'MooseX::MultiBuilder::Meta::Attribute::Trait::MultiBuilder' }

1;
