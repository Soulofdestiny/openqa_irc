use Test::More;
use Test::Bot::BasicBot::Pluggable;

my $bot = Test::Bot::BasicBot::Pluggable->new();

# basic tests
ok(my $ob = $bot->load('OpenQA'), 'load openqa module');
is($bot->tell_direct('perl'), 'I hear Ruby is better than perl..', 'simple messages work');
is($bot->tell_indirect('!perl'), 'I hear Ruby is better than perl..', 'exclamation mark tags are accepted');
isnt($bot->tell_indirect('perl'), 'I hear Ruby is better than perl..', 'only responds if addressed');

# defcon tests
$bot->{handlers}->{openqa}->set(defcon1_allowed => 'foo|bar');
like($bot->tell_direct('defcon 1'), qr/What did I tell you.*/, 'do not allow setting DEFCON works');
$bot->{handlers}->{openqa}->set(defcon1_allowed => 'test_user|foo|bar');
like($bot->tell_direct('defcon 1'), qr/Heads up.*DEFCON increase/, 'set DEFCON works!');
like($bot->tell_direct('defcon 5'), qr/We are down to/);

done_testing();
