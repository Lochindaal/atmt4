#!/bin/bash
k=0.0
for i in {0..9}
  do
    incl=0.1
    k=`echo $k + $incl | bc`
    echo $k
    python translate_beam.py --data data_asg4/prepared_data --beam-size $1 --alpha 0.7 --gamma $k --n 3 --output nBest_$k.txt
    bash postprocess_asg4.sh model_translations.txt model_translations.out
    cp model_translations.txt model_translations_beam_$1_$k.txt
    cp model_translations.out model_translations_beam_$1_$k.out
    cat model_translations.out | sacrebleu data_asg4/raw_data/test.en >> bleu_beam_$1_0.6_$k.txt
done
