package WWW::BentoShogunJP;
use 5.008001;
use strict;
use warnings;
use Furl;
use HTML::Tidy::libXML;
use XML::Diver;
use Carp;

our $VERSION = "0.01";
our $URL = 'http://bento-shogun.jp/';

my $agent = Furl->new(agent => 'WWW::BentoShogunJP/'. $VERSION);
my $tidy = HTML::Tidy::libXML->new;

sub fetch {
    my $class = shift;
    my $res = $agent->get($URL);
    croak $res->status_line unless $res->is_success;
    $class->_parse($res->content);
}

sub _parse {
    my ($class, $html) = @_;
    my $dom = $tidy->html2dom($html, 'UTF-8');
    my $diver = XML::Diver->new($dom);
    my ($date) = $diver->dive('//*[@id="menu-inner"]/h3');
    my @items_data = map { $_->dive('//a/img') } $diver->dive('//*[@id="menu-inner"]/ul/li');
    my @items = map { {
        image => $URL. $_->attr('src'), 
        name => $_->attr('alt'), 
    } } @items_data;
    {
        date => $date->text,
        items => [ @items ],
    };
}

1;
__END__

=encoding utf-8

=head1 NAME

WWW::BentoShogunJP - 弁当将軍スクレーピングライブラリ

=head1 SYNOPSIS

    use WWW::BentoShogunJP;
    my $data = WWW::BentoShogunJP->fetch;

=head1 DESCRIPTION

WWW::BentoShogunJP を使うと、簡単に今日のお弁当メニューを持ってくることができます！

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

