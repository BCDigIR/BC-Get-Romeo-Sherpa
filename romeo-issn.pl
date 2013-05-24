#!C:/Perl/bin/perl -w
use strict;

use IO::File;
use utf8;
require LWP::UserAgent;
use LWP::Simple;


#Open file for output

my $meta_file = IO::File->new('romeo-pdfs.xml', 'w')
	or die "unable to open output file for writing: $!";
binmode($meta_file, ':utf8');

while (<>)
	{
		chomp;
		print $_;
		my $issn=$_;

		my $ua = LWP::UserAgent->new;
		$ua->timeout(10);
		$ua->env_proxy;

		my $request  = HTTP::Request->new( GET => 'http://www.sherpa.ac.uk/romeo/api29.php?issn='.$issn.'&versions=all');
		my $response = $ua->request($request);
		my $meta=get($response->request->uri);

		print "$meta\n";
		$meta_file -> print($meta);

	}                                    

$meta_file->close();
=pod

use: romeo-pdfs.pl issn.txt


=cut