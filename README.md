# DVG_ONT_scripts

This repository contains a collection of Python and R scripts used for analyzing Nanopore direct RNA sequencing (DRS) data, particularly focusing on viral reads characterization and defective viral genome (DVG) analysis.

## Table of Contents
- [Overview](#overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Scripts](#scripts)
  - [Python Scripts](#python-scripts)
  - [R Scripts](#r-scripts)
- [Usage](#usage)
- [Citation](#citation)

## Overview

These scripts facilitate the analysis of Nanopore DRS data for viral genome characterization, including:
- Read length distribution analysis
- Coverage depth visualization
- Classification of spliced and unspliced viral reads
- Recombination junction site identification
- Poly(A) tail length analysis
- Chimeric read detection

## Requirements

### R Environment
- **R version:** 4.5.0 or higher
- **Platform:** Compatible with macOS, Linux, and Windows

### R Packages
```r
# Core packages
library(ggplot2)      # v4.0.1
library(dplyr)        # v1.1.4
library(data.table)   # v1.17.8
library(cowplot)      # v1.2.0

# Additional dependencies (auto-loaded)
# RColorBrewer, tidyselect, scales, etc.
```

### Python Dependencies
- Python 3.x
- pysam

## Installation

### Install R packages
```r
install.packages(c("ggplot2", "dplyr", "data.table", "cowplot"))
```

### Install Python dependencies
```bash
pip install pysam
```

## Scripts

### Python Scripts

#### `bam2bed.py`
A pysam-based custom Python script that converts BAM alignment files to BED format to facilitate downstream analysis in R.

**Usage:**
```bash
python bam2bed.py <input.bam> <output.bed>
```

---

### R Scripts

#### 1. `1_Read Length Boxplot.R`
Plots the read length distribution of Nanopore DRS reads.
- **Output:** Read length boxplots (e.g., Figure S1)

#### 2. `2_Coverage Plot.R`
Plots the coverage depth of viral reads across the genome.
- **Output:** Coverage depth visualization (e.g., Figure 1C)

#### 3. `3_Viral Spliced and Unspliced Reads.R`
Classifies viral reads into two categories:
- **Contiguous reads:** Unspliced, continuous alignment
- **Noncontiguous reads:** Spliced, with gaps in alignment

#### 4. `4_Classification of Spliced Reads.R`
Further classifies noncontiguous reads based on:
- Fragment count
- Strand orientation
- Assignment to genomic RNA (gRNA) or subgenomic RNA (sgRNA)

#### 5. Start-End Position Plots

##### 5.1. `5.1_Start-End Plot of Unspliced Reads.R`
Plots the start and end positions of contiguous reads.
- **Output:** Position distribution plot (e.g., Figure S8)

##### 5.2. `5.2_Start-End Plot of Spliced Reads.R`
Plots the start and end positions of noncontiguous reads.
- **Output:** Spliced read position plot (e.g., Figure 1E)

##### 5.3. `5.3_Start-End Plot of Chimeric Reads.R`
Plots the start and end positions of virus-host chimeric reads.
- **Output:** Chimeric read visualization (e.g., Figure 1E)

#### 6. `6_PolyA Length Plot.R`
Analyzes and plots the poly(A) tail length distribution for different classes of reads.
- **Output:** Poly(A) length distribution (e.g., Figure S12)

#### 7. `7_Recombination Boundary.R`
Visualizes the junction sites of noncontiguous reads to identify recombination events.
- **Output:** Recombination junction plot (e.g., Figure 4A)

#### 8. `8_Segment Plot.R`
Displays the read distribution along the viral reference genome, showing coverage patterns.
- **Output:** Genome segment coverage plot (e.g., Figure 6A)

## Usage

### Basic Workflow

1. **Convert BAM to BED format:**
   ```bash
   python bam2bed.py aligned_reads.bam output.bed
   ```

2. **Run R analysis scripts in order:**
   ```r
   source("1_Read Length Boxplot.R")
   source("2_Coverage Plot.R")
   source("3_Viral Spliced and Unspliced Reads.R")
   # ... continue with other scripts as needed
   ```

3. **Customize parameters** within each script according to your data and analysis needs.

## Session Information

The scripts were developed and tested in the following environment:

```r
R version 4.5.0 (2025-04-11)
Platform: aarch64-apple-darwin20
Running under: macOS 26.0.1

attached packages:
[1] cowplot_1.2.0     data.table_1.17.8 dplyr_1.1.4       ggplot2_4.0.1
```

## Citation

If you use these scripts in your research, please cite:

> [Your publication details here]

## License

[Add license information]

## Contact

For questions or issues, please open an issue in this repository or contact [your contact information].

---

**Note:** Ensure all input files are properly formatted and paths are correctly specified in the scripts before running.
