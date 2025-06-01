from Bio import SeqIO
import glob
feature_DICT = {}

for emblFile in glob.glob('result/*/*/*.embl'):
    for record in SeqIO.parse(emblFile, 'embl'):
        for feature in record.features:
            if len(feature.qualifiers['compo']) == 1:
                repeatType = feature.qualifiers['compo'][0].split('_')[0]
            else:
                print('bug!')

            for part in feature.location.parts:
                start = int(part.start)
                end = int(part.end)
                if not repeatType in feature_DICT: feature_DICT[repeatType] = {'count':0, 'sum': 0}
                feature_DICT[repeatType]['count'] += 1
                feature_DICT[repeatType]['sum'] += (end - start)

fout = open('ref.report', 'w')
for repeatType in feature_DICT:
    context = [repeatType, feature_DICT[repeatType]['count'], feature_DICT[repeatType]['sum']]
    fout.write('\t'.join(map(str, context)) + '\n')
fout.close()