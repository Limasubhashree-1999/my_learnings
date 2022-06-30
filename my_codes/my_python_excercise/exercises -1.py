


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
print(x)

A = 'abc.java'
x = A.lstrip(("abc"))
print(x)

A = [1,2,3,4]
print(A[0],A[-1])

examdate = ("2o.5.2022")
print("Exam date will start from:"+examdate)

#A = int(input("input the integer:"))
n1 = int(2)
n2 = int(3)
n4 = int(5)
n6 = (n1+n2+n4)
print(n6)

import calendar
cal = (2022,5)
print("here is the calendar:")
print(cal)

from datetime import date
A = date(2022,3,7)
B = date(2023,5,2)
delta = B - A 
print(delta.days)

import getpass
print(getpass.getuser())

print("Helloweveryone")
