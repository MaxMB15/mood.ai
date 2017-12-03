import csv

text_list = []
test = [1,2,3,4,5,6,7]


with open('output1.csv', 'wb') as csvoutput:
	with open('training_data copy.csv','rb') as csvinput:
		reader = csv.reader(csvinput)
		reader.next()
		for row in reader:
			text_list.append(row[1])


	import indicoio
	indicoio.config.api_key = '7b1250a3e26b0a9a5f8f5e424d60e7b4'

	v = indicoio.emotion(text_list)


	writer = csv.writer(csvoutput, quotechar='"', delimiter=',', quoting=csv.QUOTE_ALL, skipinitialspace=True)
	with open('training_data copy.csv','rb') as csvinput:
		reader = csv.reader(csvinput)
		for row, vx in zip(reader, v):
			print vx
			if row[0] == "":
				writer.writerow(row)
			else:
				row.append(vx['joy'])
				row.append(vx['sadness'])
				row.append(vx['anger'])
				row.append(vx['fear'])
				row.append(vx['surprise'])

				writer.writerow(row)





#





#print text_list



