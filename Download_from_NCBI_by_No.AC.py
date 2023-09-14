#!/usr/bin/python
# -*- coding: UTF-8 -*-


from Bio import Entrez

import os,sys

from Bio.Seq import Seq

from Bio.SeqRecord import SeqRecord

from Bio.SeqFeature import SeqFeature, FeatureLocation

from Bio import SeqIO

import sys, os, argparse, os.path,re,math,time



parser = argparse.ArgumentParser(description='This script is used to get umapped reads from  fastq')





parser.add_argument('-f','--idlist',help='Please ID list file',required=True)

parser.add_argument('-o','--out_dir',help='Please input complete out_put directory path',default = os.getcwd(),required=False)



parser.add_argument('-n','--name',default ='demo_seq',required=False,help='Please specify the output, demo_seq')

args = parser.parse_args()

dout=''

if os.path.exists(args.out_dir):

    dout=os.path.abspath(args.out_dir)

else:

    os.mkdir(args.out_dir)

    dout=os.path.abspath(args.out_dir)

output_handle = open(dout+'/'+args.name+'.fa', "w")

in_handle = open(args.idlist, "r")

Entrez.email = "huangls@biomics.com.cn"     # Always tell NCBI who you are

#handle = Entrez.efetch(db="nucleotide", id="EU490707", rettype="gb", retmode="text")

#print(handle.read())



for i in in_handle:

    i.strip()

    if i[0]=="#":continue

    tmp=re.split('\s+',i)





    handle = Entrez.efetch(db="nucleotide", id=tmp[0], rettype="fasta", retmode="text")

    #print(handle.read())

    record = SeqIO.read(handle, "fasta")



    SeqIO.write(record, output_handle, "fasta")



output_handle.close()

in_handle.close()
