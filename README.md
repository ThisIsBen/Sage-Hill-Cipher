# Sage-Hill-Cipher
The goal of this program is to implement Hill Cipher using Sage. 
Sage is a powerful mathematic software which can compute matrix determinants and inverses. 
So you do not need to implement those functions
yourselves. 
This program is able to do the following:
1) Read the key from a text file. The key can be a matrix of any dimension (nxn).
2) Read a text file, encrypt its content, and save the result in another file. The program will  partition the
file into blocks and encrypt them separately.
3) Restore the cipher text file back to plaintext
4) The program is able to handle all the ASCII code characters

## Perform Encryption
```
sage Q36064010.sage e Key.txt
```

## Perform Decryption
```
sage Q36064010.sage d Key.txt
```

Both Encryption and Decryption is applied to the content stored in hillCipherInput.txt.

## What's special about this Hill Cipher?
When I use the nxn Key matrix(n is a positive integer) to perform Encryption or Decryption, 
It can handle the situation that the number of characters stored in hillCipherInput.txt can't be divided by n.

For example, if I use a 2x2 Key matrix like this,
![](https://github.com/ThisIsBen/Sage-Hill-Cipher/images/KeyMatrix.png)
and the number of characters stored in hillCipherInput.txt can't be divided by 2 .(There are 3 characters per line) 
![](https://github.com/ThisIsBen/Sage-Hill-Cipher/images/Plaintext.png)
We append some spaces(' ') to the plaintext content of hillCipherInput.txt to make it be divided by 2.
![](https://github.com/ThisIsBen/Sage-Hill-Cipher/images/Encryption.png)
Then we remove the spaces(' ') after decryption to restore the original plaintext.
![](https://github.com/ThisIsBen/Sage-Hill-Cipher/images/Decryption.png)
