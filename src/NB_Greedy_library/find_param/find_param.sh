#!/bin/sh
UCSD_ROOT_PATH="/fs/home/jw865/peptide-catalysis"
UCSD_outname="AcpS_specific"
UCSD_datafile="${UCSD_ROOT_PATH}/data/2014_06_03_orthogonal_labeling_data/Training_Set_Cumulative.csv"
rm -R ${UCSD_ROOT_PATH}/temp/find_param/${UCSD_outname}
mkdir ${UCSD_ROOT_PATH}/temp/find_param/${UCSD_outname}

N=336
for i in $(seq 1 $N)
do
    jsub "${UCSD_ROOT_PATH}/src/NB_Greedy_library/find_param/find_param.nbs ${UCSD_ROOT_PATH} ${UCSD_datafile} $i ${UCSD_outname}" 
done
