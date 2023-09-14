#!/usr/bin/perl -w
#use strict;

open my $fh, "blast.xml" or die "Cannot open the blast file\n";
local $/ = "<\/Iteration>\n";

print "Query\tHit\tAlign_length\tQuery_start\tQuery_end\tHit_start\tHit_end\tHit_lenth\tIdentity(%)\tHit_description\n";

while(<$fh>){
	my $query = $1 if ($_ =~ /<Iteration_query-def>(\S+)<\/Iteration_query-def>/);
	my $query_len = $1 if ($_ =~ /<Iteration_query-len>(\S+)<\/Iteration_query-len>/);
	while ($_ =~ /<Hit>(.*?)<\/Hit>/sg){
		chomp(my $hit = $1);
		my $id = $1 if ($hit =~ /<Hit_id>(.*)<\/Hit_id>/);
		my @nid=split /\|/,$id;
		#print "$id\t@nid\n";
		$id=$nid[3];
		my $def = $1 if ($hit =~ /<Hit_def>(.*?)<\/Hit_def>/);
		#my $num = 0;
		my $hit_len = $1 if ($_ =~ /<Hit_len>(\S+)<\/Hit_len>/);
	while ($hit =~ /<Hsp>(.*?)<\/Hsp>/sg){
#		$num++;
		my $hsp = $1;
		my $query_from = $1 if ($hsp =~ /<Hsp_query-from>(\S+)<\/Hsp_query-from>/);
		my $query_to = $1 if ($hsp =~ /<Hsp_query-to>(\S+)<\/Hsp_query-to>/);

		my $hit_from = $1 if ($hsp =~ /<Hsp_hit-from>(\S+)<\/Hsp_hit-from>/);
		my $hit_to = $1 if ($hsp =~ /<Hsp_hit-to>(\S+)<\/Hsp_hit-to>/);
#		my $hit_frame = $1 if ($hsp =~ /<Hsp_query-frame>(\S+)<\/Hsp_query-frame>/);
		my $qseq = $1 if ($hsp =~ /<Hsp_qseq>(\S+)<\/Hsp_qseq>/);
		my $align_len = $1 if ($hsp =~ /<Hsp_align-len>(\S+)<\/Hsp_align-len>/);
		my $ident_len = $1 if ($hsp =~ /<Hsp_identity>(\S+)<\/Hsp_identity>/);
                my $ident = ($ident_len/$align_len) *100;
                $identity = sprintf("%.2f",$ident);
 #		print ">$query;orf$num len=$align_len frame:$hit_frame start:$query_from end:$query_to $id $def\n";
	print "$query\t$id\t$align_len\t$query_from\t$query_to\t$hit_from\t$hit_to\t$hit_len\t$identity\t$def\n";
		}
	}
}
close $fh
