bash helper.sh

bash tx-dr.sh | sed s/White/TX,White/ | sed s/Black/TX,Black/ | sed s/Hispanic/TX,Hispanic/ | sed s/Other/TX,Other/

bash fl-dr.sh | sed s/BM/FL,Black/ | sed s/WM/FL,White/ | sed s/OM/FL,Other/ | sed s/HM/FL,Hispanic/ | sed s/BF/FL,Black/ | sed s/WF/FL,White/ | sed s/OF/FL,Other/ | sed s/HF/FL,Hispanic/

bash ca-dr.sh | sed s/WHI/CA,White/ | sed s/BLA/CA,Black/ | sed s/HIS/CA,Hispanic/ | sed s/OTH/CA,Other/
