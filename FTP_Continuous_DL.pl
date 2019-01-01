#!/usr/bin/perl

use strict;

use Net::FTP;
my $host="192.168.1.200";
my $user="test";
my $password="test";
my $file_to_get="jellyfish-25-mbps-hd-hevc.3gp";  
my $iteration=0;



while(1) {

$iteration=$iteration+1;
print "Iteration: $iteration\n";

my $f;

if($f=Net::FTP->new($host)) { 
	print "Successfully connected to $host\n"; 
}
else {
	print "Could not connect to $host\n";
	next;
}	


if($f->login($user,$password)) { 
	print "Successfully logged in to $host\n";
}
else {
		print "Could not login to host\n";
		
		if($f->quit()) {
		print "Successfully closed connection to $host\n";  
		}
		else {
			system("sleep 300");
		}
	next;
}

$f->binary();

eval {$f->get($file_to_get)};

if($@ =~ /Timeout/) {
	print "File could not be downloaded from $host due to timeout\n";
	system("sleep 300");
	next;	
}
else {
	print "Successfully downloaded file from $host\n"; 
}


if($f->quit()) {
	print "Successfully closed connection to $host\n";  
}
else {
	system("sleep 300");
}

system("sleep 5");
}
