#!/usr/bin.perl -w 

print "Name\tTotal_reads\t%GC\tQ20\tQ30\n";
opendir (DIR, "./") or die "can't open the directory!";
@dir = readdir DIR;
foreach $file ( sort  @dir) 
{
next unless -d $file;
next if $file eq '.';
next if $file eq '..';
#$file_name=()[];
#print "$file\n";
$total_reads =  `grep '^Total' ./$file/fastqc_data.txt`;
#print $total_reads;
$total_reads =(split(/\s+/,$total_reads))[2];
$GC = `grep '%GC' ./$file/fastqc_data.txt`;
$GC = (split(/\s+/,$GC))[1];
chomp $GC;
open FH , "<./$file/fastqc_data.txt";
while (<FH>)
    {
    next unless /#Quality/;
    while (<FH>)
        {
            @F = split;
            $hash{$F[0]} = $F[1];
            last if />>END_MODULE/;
        }
    }

$all=0;$Q20=0;$Q30=0;
$all += $hash{$_} foreach keys %hash;
$Q20 += $hash{$_} foreach 0..20;
$Q30 += $hash{$_} foreach 0..30;
$Q20 = (1-$Q20/$all)*100;
$Q30 = (1-$Q30/$all)*100;
$tmp20 = sprintf("%.2f",$Q20);
$tmp30 = sprintf("%.2f",$Q30);
#print $tmp20;
print "$file\t$total_reads\t$GC\t$tmp20\t$tmp30\n";
#print "$all\n";
                                                         
}
