use strict;
use Test::More;
use WWW::BentoShogunJP;

open my $fh, '<', 't/index.html' or die $!;
my $html = do { local $/; <$fh> };
close $fh;

my $res = WWW::BentoShogunJP->_parse($html);

isa_ok($res, 'HASH');

my $expect = {
  'date' => "6\x{6708}16\x{65e5}(\x{706b})\x{306e}\x{30e1}\x{30cb}\x{30e5}\x{30fc}",
  'items' => [
    {
      'image' => 'http://bento-shogun.jp/menu/img/dx/dxorenokaraage.jpg',
      'name' => "DX\x{4ffa}\x{306e}\x{5510}\x{63da}\x{3052}\x{5f01}\x{5f53}"
    },
    {
      'image' => 'http://bento-shogun.jp/menu/img/meat/torimayo.jpg',
      'name' => "\x{9d8f}\x{30de}\x{30e8}\x{ff06}\x{3072}\x{3058}\x{304d}\x{3054}\x{98ef}\x{5f01}\x{5f53}"
    },
    {
      'image' => 'http://bento-shogun.jp/menu/img/meat/tontoro.jpg',
      'name' => "\x{8c5a}\x{30c8}\x{30ed}\x{306e}\x{97d3}\x{56fd}\x{98a8}\x{30b3}\x{30c1}\x{30e5}\x{30b8}\x{30e3}\x{30f3}\x{7092}\x{3081}\x{5f01}\x{5f53}"
    },
    {
      'image' => 'http://bento-shogun.jp/menu/img/healthy/shinjyuujituyasai.jpg',
      'name' => "\x{65b0}\x{5145}\x{5b9f}\x{91ce}\x{83dc}\x{5f01}\x{5f53}"
    }
  ]
};

is_deeply($res, $expect);

done_testing;
