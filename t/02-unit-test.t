use Test::More tests => 34;
use BankAccount::Validator::UK;

while (<DATA>)
{
    chomp;
    next if /^\#/;
    my ($description, $sort_code, $account_number, $expected) = split /\|/;
    my $account = BankAccount::Validator::UK->new();
    my $actual = $account->is_valid($sort_code, $account_number) ? 'Y' : 'N';
    ok($actual eq $expected, $description);
}    
__DATA__
Pass modulus 10 check.|089999|66374958|Y
Pass modulus 11 check.|107999|88837491|Y
Pass modulus 11 and double alternate checks.|202959|63748472|Y
Exception 10 & 11 where first check passes and second check fails.|871427|46238510|Y
Exception 10 & 11 where first check fails and second check passes.|872427|46238510|Y
Exception 10 where in the account number ab=09 and the g=9. The first check passes and second check fails.|871427|09123496|Y
Exception 10 where in the account number ab=99 and the g=9. The first check passes and the second check fails.|871427|99123496|Y
Exception 3, and the sorting code is the start of a range. As c=6 the second check should be ignored.|820000|73688637|Y
Exception 3, and the sorting code is the end of a range. As c=9 the second check should be ignored.|827999|73988638|Y
Exception 3. As c<>6 or 9 perform both checks pass.|827101|28748352|Y
Exception 4 where the remainder is equal to the checkdigit.|134020|63849203|Y
Exception 1 - ensures that 27 has been added to the accumulated total and passes double alternate modulus check.|118765|64371389|Y
Exception 6 where the account fails standard check but is a foreign currency account.|200915|41011166|Y
Exception 5 where the check passes.|938611|07806039|Y
Exception 5 where the check passes with substitution.|938600|42368003|Y
Exception 5 where both checks produce a remainder of 0 and pass.|938063|55065200|Y
Exception 7 where passes but would fail the standard check.|772798|99345694|Y
Exception 8 where the check passes.|086090|06774744|Y
Exception 2 & 9 where the first check passes and second check fails.|309070|02355688|Y
Exception 2 & 9 where the first check fails and second check passes with substitution.|309070|12345668|Y
Exception 2 & 9 where a<>0 and g<>9 and passes.|309070|12345677|Y
Exception 2 & 9 where a<>0 and g=9 and passes.|309070|99345694|Y
Exception 5 where the first checkdigit is correct and the second incorrect.|938063|15764273|N
Exception 5 where the first checkdigit is incorrect and the second correct.|938063|15764264|N
Exception 5 where the first checkdigit is incorrect with a remainder of 1.|938063|15763217|N
Exception 1 where it fails double alternate check.|118765|64371388|N
Pass modulus 11 check and fail double alternate check.|203099|66831036|N
Fail modulus 11 check and pass double alternate check.|203099|58716970|N
Fail modulus 10 check.|089999|66374959|N
Fail modulus 11 check.|107999|88837493|N
Exception 12/13 where passes the modulus 11 check (in this example, modulus 10 check fails, however, there is no need for it to be performed as the first check passed).|074456|12345112|Y
Exception 12/13 where passes the modulus 11 check (in this example, modulus 10 check passes as well, however, there is no need for it to be performed as the first check passed).|070116|34012583|Y
Exception 12/13 where fails the modulus 11 check, but passes the modulus 10 check.|074456|11104102|Y
Exception 14 where the first check fails and the second check passes.|180002|00000190|Y