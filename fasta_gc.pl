#!/usr/bin/perl -w
print"input your file,then press Enter!n";
file=<STDIN>;openIN,"file";
open OUT,">rsult";
while(<IN>){
    chomp;
    if (/>/){
    head=_;
    head=~s/>//g;     
            }
    else{      
        $seq{$head}.=$_;
        }      
            }         

local/=undef;

while ((title,line)=each %seq)
{
    count=0;
    num=lengthline;
    for(i=0;i<num;i++)
    $word=substr($line,$i,1);
    if($word= /[GC]/)$count++;
    else$ratio=$count/$num;
    printOUT"title\tratio\n";        
}
exit;


#注释文件为awk实现方法 #awk '/^>/ && NR>1{print "";}{ printf "%s",/^>/?$0"\t":$0}' file.fa |awk '{print $1"\n"length($n)}' # n为你要输出的标头信息的第几列，0表示整行，1,..表示默认被空格分开的第几列内容
