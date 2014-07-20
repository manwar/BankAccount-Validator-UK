use 5.006;
use strict;
use warnings FATAL => 'all';
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'BankAccount::Validator::UK',
    license             => 'artistic_2',
    dist_author         => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    dist_version_from   => 'lib/BankAccount/Validator/UK.pm',
    release_status      => 'stable',
    configure_requires  => {
        'Module::Build' => 0,
    },
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'Moo' => 0,
        'namespace::clean' => 0,
    },
    add_to_cleanup     => [ 'BankAccount-Validator-UK-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
