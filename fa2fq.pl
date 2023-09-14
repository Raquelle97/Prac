#!/usr/bin/perl -w

 #Author: lh3

use Getopt::Std;

my $usage = qq(
Usage: fq_all2std.pl

Command: scarf2std Convert SCARF format to the standard/Sanger FASTQ
fqint2std Convert FASTQ-int format to the standard/Sanger FASTQ
sol2std Convert Solexa/Illumina FASTQ to the standard FASTQ
fa2std Convert FASTA to the standard FASTQ
fq2fa Convert various FASTQ-like format to FASTA
instruction Explanation to different format
example Show examples of various formats

Note: Read/quality sequences MUST be presented in one line.
\n);

die($usage) if (@ARGV < 1);

# Solexa->Sanger quality conversion table
my @conv_table;
for (-64..64) {
$conv_table[$_+64] = chr(int(33 + 10*log(1+10**($_/10.0))/log(10)+.499));
}

 #parsing command line
my $cmd = shift;
my %cmd_hash = (scarf2std=>\&scarf2std, fqint2std=>\&fqint2std, sol2std=>\&sol2std, fa2std=>\&fa2std,
fq2fa=>\&fq2fa, example=>\&example, instruction=>\&instruction);
if (defined($cmd_hash{$cmd})) {
&{$cmd_hash{$cmd}};
} else {
die("** Unrecognized command $cmd");
}

sub fa2std {
my %opts = (q=>25);
getopts('q:', \%opts);
my $q = chr($opts{q} + 33);
warn("– The default quality is set to $opts{q}. Use '-q' at the command line to change the default.\n");
while (<>) {
if (/^>(\S+)/) {
print "\@$1\n";
$_ = <>;
print "$_+\n", $q x (length($_)-1), "\n";
}
}
}


