#!/home/sage/sage/sage

import sys
from sage.all import *
import fileinput


#
# Function for reading the key matrix
# Modify this function so that it supports NxN matrices
#
def ReadHillCipherKey(keyFileName):
	row_num = 0; K = None
	#declare the global var numOfSupportCode
	global numOfSupportCode
	global KeyMatrixDim

	keyFile = open(keyFileName, "r")

	if (keyFile is None):
		return None
	
	for line in keyFile:
		# Parse each line into a list of numbers
		line = line.strip()
		row = line.split("\t")	# The result of this line is a list of arrays
		row = [int (num_str) for num_str in row] # Convert to list of integers

		#get length of the row to get num of column
		col_len=len(row)

		

		# Todo 1: Modify the following so that this function supports nxn matrix			
		if (col_len < 2):
			raise ValueError, "Key matrix must be a nxn matrix,n must be greater than 1"
		if (col_len-1 < row_num):
			raise ValueError, "Key matrix must be a nxn matrix"

		if (row_num == 0):
			K = matrix(ZZ,col_len)

		

		K.set_row(row_num, row)
		row_num = row_num + 1



		


	#assing the global var numOfSupportCode
	numOfSupportCode=128
	KeyMatrixDim=col_len
	
	# Validate the key matrix
	
	if (not K in MatrixSpace(IntegerModRing(numOfSupportCode),col_len)):
		raise ValueError, "Key matrix must be a nxn matrix over the integers mod "
	if (K.det() == 0):
		raise ValueError, "Key matrix must be an invertible matrix."
	
	keyFile.close()

	
	

	return K

#Define the input file name
#hillCipherInputFile="hillCipherOutputBen.txt"
hillCipherInputFile="hillCipherInput.txt"

# Check the arguments
if (len(sys.argv) != 3) or (sys.argv[1] not in ["d", "e"]):
	print "Usage: %s e/d key_file"%sys.argv[0]
	print "Encrypt/decrypt a text file using Hill Cipher"
	sys.exit	

Key = ReadHillCipherKey(sys.argv[2])

if (Key is None):
	sys.exit



# The following code packs data files into a 1xn matrix and 
# performs encryption/decryption




count = 0; plist=list([])

#read the file that is going to be encrypted or descrypted
targetFile = open(hillCipherInputFile, "r")

if (targetFile is None):
	raise ValueError, "The hill cipher input file,hillCipherInput.txt, does not exist."


#open the output file
with open('hillCipherOutput.txt', 'w') as hillCipherOutput_file:
    

	

	


	for line in targetFile:
		
		#strip the line only from end
		line = line.rstrip()

		#display the input text in terminal,too.
		print "The input line: "
		print line


		#add 'space' to make it the right length to fit the key matrix
		numOfNullSpace= len(line) % KeyMatrixDim 
		#print numOfNullSpace

		for i in range(0,numOfNullSpace):
			line=line+' '


		#we use outLine string to keep all the hill cipher #result for the current line.
		
		outLine = ""

		for ch in line:

			#print ch
			

			plist.append(ord(ch))

			# Todo 2: Modify the following so that this supports NxN matrices
			count = (count + 1) % KeyMatrixDim
			if (count == 0):
				Block_text = matrix(ZZ,1,KeyMatrixDim,plist)

				# Todo 3: Modify this to perform encryption/decryption
				#encryption
				if(sys.argv[1]=="e"):
					
					#print Block_text
					Cipher = (Block_text * Key)%numOfSupportCode
					outputResult=Cipher
				

				#descryption
				elif (sys.argv[1]=="d"):
					#step 1
					Key_det=Key.det()
					#step 2
					Key_det=Key_det % numOfSupportCode
					#step 3
					det_inverse=inverse_mod(Key_det,numOfSupportCode)
					#step 4
					adj_Key = Key.adjoint() 
					#step 5
					adj_Key = adj_Key % numOfSupportCode
					#step 6
					Inverse_Key=(adj_Key * det_inverse) % numOfSupportCode
					#step 7
					Plain=(Block_text * Inverse_Key) % numOfSupportCode
					outputResult=Plain


				
				for i in range(KeyMatrixDim):				
					outLine = outLine + str(chr(outputResult[0,i]))
				plist = list([])

		#write the hill ciphter result of the current line to #file 
		if(sys.argv[1]=="e"):		
			hillCipherOutput_file.write(outLine+ "\n")
			#display the output text in terminal,too.
			print "Encryption Result of the Input line: "

		elif(sys.argv[1]=="d"):
			outLine=outLine.rstrip()
			hillCipherOutput_file.write(outLine+ "\n")
			#display the output text in terminal,too.
			print "Descryption Result of the Input line: "

		#display the E/D result on the terminal, too.
		print outLine
				
	

	targetFile.close()

