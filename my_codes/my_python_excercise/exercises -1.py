


print (""" Twinkle,Twinkle Little Star
                 How I Wander What You Are!
                     Up Above The World So High,
                     Like A Diamond In The Sky.
            Twinkle Twinkle Little Star
                 How I Wander What You Are.""")                           
 
import platform
print(platform.python_version())

import datetime
print(datetime.datetime.now());

A = ("input the first name:")
B = ("input the last name:")
print("hello "+"A"+" "+"B")

A = "1,2,23,4,5"
x = A.rsplit(",")
Y = tuple(A)
print(x)
print(Y)

A = 'abc.java'
x = A.lstrip(("abc"))
print(x)

A = "subhashree.sahoo"
X = A.rstrip(("sahoo"))

A = [1,2,3,4]
print(A[0],A[3])

examdate = ("2o.5.2022")
print("Exam date will start from:"+examdate)

#A = int(input("input the integer:"))
n1 = int(2)
n2 = int(3)
n4 = int(5)
n6 = (n1+n2+n4)
print(n6)

A = 5
X = A+A*A+A*A*A
print(X)

A = 5
X = A*A*A*A
print(X)

import calendar
cal = ("2022,5")
print("here is the calendar:"+(cal))


from datetime import date
A = date(2022,3,7)
B = date(2022,3,10)
delta = B - A 
print(delta)

import getpass
print(getpass.getuser())

print("Helloweveryone")

import datetime
print(datetime.datetime.now());