bash ./pipe/prepare.sh
bash ./pipe/repeatmasker.sh
bash ./pipe/clariTE.sh
python ./script/create_report.py 1> ref.report.log 2> ref.report.err
