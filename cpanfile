requires 'perl', '5.008001';
requires 'HTML::Tidy::libXML';
requires 'XML::Diver';
requires 'Furl';
requires 'Carp';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

