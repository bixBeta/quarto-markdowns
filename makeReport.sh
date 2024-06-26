#!/bin/bash

display_usage(){
  echo "------------------------------------------------------------------------------------------------------------------"
  echo "run the script using the following syntax:"
  echo "    bash" $0 "<-k3> <Report_Title> <Genome> <Annot>"
  echo ""
  echo " -k1  = knit with all headers (including MA-plot)"
  echo " -k2  = knit with all headers Filtered (2 projects e.g. PCA-flt.png)"
  echo " -k3  = knit w/o GeneBodyCov"
  echo " -k4  = knit w/o GeneBodyCov Filtered (2 projects e.g. PCA-flt.png)"
  echo " -a1  = knit atac"
  echo " -a2  = knit atac Filtered (2 projects e.g. PCA-flt.png)"
  echo " -s1  = knit smRNA"
  echo "------------------------------------------------------------------------------------------------------------------"
}

T=$2
G=$3
A=$4


knit_full_report(){

  scp /Users/fa286/Documents/GitHub/quarto-markdowns/qmds/full-report-nf.qmd .
  
  quarto render full-report-nf.qmd -P title:$T -P genome:$G -P annot:$A -o ${T}-Report.html

  rm *.qmd

}

knit_full_filtered(){

  scp /Users/fa286/Documents/GitHub/quarto-markdowns/qmds/full-report-nf-filtered.qmd .
  
  quarto render full-report-nf-filtered.qmd -P title:$T -P genome:$G -P annot:$A -o ${T}-Report.html

  rm *.qmd

}


knit_nogbcov(){

  scp /Users/fa286/Documents/GitHub/quarto-markdowns/qmds/nogbcov-report-nf.qmd .
  
  quarto render nogbcov-report-nf.qmd -P title:$T -P genome:$G -P annot:$A -o ${T}-Report.html

  rm *.qmd

}


knit_nogbcov_filtered(){

  scp /Users/fa286/Documents/GitHub/quarto-markdowns/qmds/nogbcov-filtered-nf.qmd .
  
  quarto render nogbcov-filtered-nf.qmd -P title:$T -P genome:$G -P annot:$A -o ${T}-Report.html

  rm *.qmd

}


knit_atac(){

  scp /Users/fa286/Documents/GitHub/quarto-markdowns/qmds/atac-nf.qmd .
  
  quarto render atac-nf.qmd -P title:$T -P genome:$G -P annot:$A -o ${T}-Report.html

  rm *.qmd

}


knit_atac_filtered(){

  scp /Users/fa286/Documents/GitHub/quarto-markdowns/qmds/atac-filtered-nf.qmd .
  
  quarto render atac-filtered-nf.qmd -P title:$T -P genome:$G -P annot:$A -o ${T}-Report.html

  rm *.qmd

}


knit_smrna(){

  scp /Users/fa286/Documents/GitHub/quarto-markdowns/qmds/smrna.qmd .
  
  quarto render smrna.qmd -P title:$T -P genome:$G -P annot:$A -o ${T}-Report.html

  rm *.qmd

}


raise_error() {
  echo "-------------------------------------------------------------------"
  local error_message="$@"
  echo "${error_message}" 1>&2;
  echo "-------------------------------------------------------------------"
}



case $1 in
    -h|--help)
      display_usage
      ;;
    -k1|--knit1)
      knit_full_report
      ;;
    -k2|--knit2)
      knit_full_filtered
      ;;
    -k3|--knit3)
      knit_nogbcov
      ;;
    -k4|--knit4)
      knit_nogbcov_filtered
      ;;

    -a1)
    knit_atac
     ;;

    -a2)
      knit_atac_filtered
      ;;

    -s1)
      knit_smrna
      ;;

     *)
      raise_error "Unknown argument(s): ${1}"
      display_usage
      ;;
esac