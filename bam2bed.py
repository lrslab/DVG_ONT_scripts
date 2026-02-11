import numpy as np
import pysam
import argparse
import pandas as pd
from tqdm import tqdm

bam_path='/home/zhguo/Data/virus_s.bam'
def main(args):
    bam_path=args.input
    result_name = args.output
    map_label = args.label
    infile = pysam.AlignmentFile(bam_path, "rb") ## r for reading; b for compressed bam file
    read_num=infile.mapped+infile.unmapped
    pbar = tqdm(total=read_num, position=0, leave=True, unit="reads")
    result_list=[]
    for line in infile:
        chro=line.reference_name ## reference name
        read_id = line.qname ## query name
        start_position=line.reference_start ## 0-based leftmost coordinate 
        end_position=line.reference_end ## reference_end points to one past the last aligned residue. Returns None if not available (read is unmapped or no cigar alignment present) 
        read_start=line.query_alignment_start ## start index of the aligned query portion of the sequence (0-based, inclusive). This the index of the first base in query_sequence that is not soft-clipped; query_sequence represents read sequence bases, including soft clipped bases (None if not present)
        read_end=line.query_alignment_end ## end index of the aligned query portion of the sequence (0-based, exclusive) ; this the index just past the last base in query_sequence that is not soft-clipped
        length=line.query_length ## the length of the query/read; the length includes soft-clipped bases and is equal to len(query_sequence); this property is read-only but is updated when a new query sequence is assigned to this AlignedSegment. Returns 0 if not available
        mapped_length=line.reference_length ## aligned length of the read on the reference genome
        if line.is_reverse == True: ## true if read is mapped to reverse strand 
            strand="-"
        else:
            strand='+'
        if line.is_unmapped == True: ## true if read itself is unmapped 
            label="unmapped"
        else:
            label=map_label
        temp = [chro,start_position,end_position,read_start,read_end,length,mapped_length,strand,read_id,label]
        result_list.append(temp)
        pbar.update(1)
    df=pd.DataFrame(np.array(result_list))
    df.to_csv(result_name,header=None,index=None,sep="\t")

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", default=bam_path,
                        help="bam file")
    parser.add_argument("--output", default="result.bed",
                        help="output bed file name")
    parser.add_argument("--label", default="virus", help="type of mapped read")

    args = parser.parse_args()
    main(args)
