'''
Created on 07-Jun-2025

@author: sonyarani.dhara
'''


'''Find Factorial of Numbers '''
# fact=1;
# for val in range(4,0,-1):
#     fact=fact*val
# print(fact)

'''Find the Sum of First n numbers '''

# num=5
# sum=0
# i=0
# while(i<=num):
#     sum=sum+i
#     i=i+1
#
# print(sum)

'''Print Numbers from range 1 to 100 '''
# for val in range(1,101,1):
#     print(val)

'''Print Numbers from range 1 to 100 '''
# for val in range(100,0,-1):
#     print(val)


'''Print Table of Number '''
# tablenum=5
# for val in range(1,11,1):
#     print(tablenum,' * ',val,' = ',tablenum*val)

'''Print the Element of the following list using  a loop '''

# numList = (1, 4, 9, 16, 25, 36, 49, 64, 81, 100)
# i=0;
# for val in numList:
#     print(numList[i])
#     i=i+1

'''Search for  the Element in the following list using  a loop '''

# numList = (1, 4, 9, 16, 25, 36, 49, 64, 81, 100)
# elementSearchFor=81
# i=0;
# for val in numList:
#     if(elementSearchFor==numList[i]):
#         print(numList[i],"-Element Found at Index : ",str(i))
#         break
#     print(numList[i])
#     i=i+1


'''Break at Element '''

# numList = (1, 4, 9, 16, 25, 36, 49, 64, 81, 100)
# i = 0  # Start at index 0
#
# while i < len(numList):
#     print(numList[i])
#     if numList[i] == 25:
#         break
#     i += 1  # Proper increment

'''Continue at Element Found'''

# numList = (1, 4, 9, 16, 25, 36, 49, 64, 81, 100)
# i = 0  # Start at index 0
#
# while i < len(numList):
#
#     if numList[i] == 25:
#         i+=1
#         continue
#     print(numList[i])
#     i += 1  # Proper increment
#



'''Search for Number in Tuple using Loop'''
# numList=(1,4,9,16,25,36,49,64,81,100)
#
# #print(len(numList))
# i=1
# flag=False
# searchInput=int(input("Enter Number to Find :"))
# while(i<len(numList)):
#     if(searchInput==numList[i]):
#         flag=True
#     i+=1
#
# if(flag==True):
#     print(" Number Found ")
# else:
#     print (" Number Not Found ")


'''Print Numbers from 1- t0 100 '''
# i = 1
# while i <= 100:
#     print(i)
#     i+=1
#
#

'''Print Numbers from 100 t0 1'''
# i=100
# while(i>0):
#     print(i)
#     i-=1



'''Print Multiplication of Table 1'''
# n=5
# i=1
# while(i<=10):
#     print(n,' * ',i," = ",n*i)
#     i+=1