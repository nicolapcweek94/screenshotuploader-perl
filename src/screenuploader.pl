#!/usr/bin/env perl
use strict;
use warnings;
use Net::FTPSSL;
use Digest::SHA3 qw(sha3_256_hex);
use Clipboard;
use v5.10;

my $ftps = Net::FTPSSL -> new ("host", Encryption => EXP_CRYPT, Debug => 1) or die "Can't connect to host! $!";
my $filename = "";

$ftps -> login ("user", "password") or die "Couldn't login! $!";
if ($ARGV[0] =~ /^\S+\\(.+?)\.([^\.]+?)$/i)
{
    $filename = sha3_256_hex($1) . ".$2";
    $ftps -> put ($ARGV[0], "public_html/screens/" . $filename);
}
else
{
    $filename = "The first (and only) argument must be a Windows-style path.";
}

$ftps -> quit();

given (int(rand(3)))
{
    when (/0/) { print  "domain1", $filename; Clipboard -> copy("domain1" . $filename); }
    when (/1/) { print  "domain2", $filename; Clipboard -> copy("domain2" . $filename); }
    when (/2/) { print  "domain3", $filename; Clipboard -> copy("domain3" . $filename); }
}