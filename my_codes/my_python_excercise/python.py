A = list(("apple","banana","chery","lichi","mango","guava"))
print(len(A))
print(type(A))
print(A)

print(A[2:4])

A.append("chocolate")
print(A)
A.insert(2,"ripe mango")
print(A)
A.remove("chocolate")
print(A)
A.pop(2)
print(A)


B = A.copy()
print(B)

B = B.clear()
print(B)

print("count for lichi:", A.count("lichi"))
print("count for guava:", A.count("guava"))

A.append("lichi")
print(A)



A = ['1','2','3','4','5']
B = ['lima','sima','babu','rima']
A.extend(B)


C = '_'
print (C.join(A))

print(B.count("lima"))

print (B.index("rima"))
B.reverse()
print(B)

C = " my name is lima"
X = C.encode()
print(X)

Y = C.find("name")
print(Y)

B = ('lima','sima','babu','rima')
E = list(B)
E[3] = 'rakhi'
B = tuple(E)
print(B)
X = ('1','2','3')
Y = ('lima','rima')
Z = X+Y

S = X.index('3')
print(S)

A = {'1','2','3','4','5'}
B = {'lima','sima','rima','babu','rakhi','ranu'}

A.add('6')
print(A)

A.update(B)
print(A)

C = A.copy()
print(C)

D = A.union(B)
print(D)


thiscar = {
"name" : "A4",
"model" : "car",
"brand" : "AUDI",
"year" : 2020 
}
print(thiscar)

print(thiscar["brand"])

print(thiscar["model"])
print(len(thiscar))
print(len("name"))

X = thiscar.copy()
print(X)

x = thiscar.get("year")
print(x)


family = {
    "child1":{
     "name":"lima",
     "age":22,
     "class":"pg"
    },
    "child2":{
    "name":"babu",
    "age":20,
    "class":"bsc"
    }
}      

print(family)

family = {
    "child1":"first",
     "name": "lima",
     "age":22,
     "class":"pg"
}

family["age"] = 23
print(family)

family["school"] = "SSVM"
print(family)

family.pop("age")
print(family)


family["age"] = "23"
print(family)

family2 = family.copy()
print(family2)

import datetime
from logging import exception
print(datetime.datetime.now())

import time
print (time.localtime());

import datetime
print(datetime.datetime(2020,5,17))

def my_function():
    print("hellow from a funtion")
my_function()

def my_function(fname):
    print(fname + " sahoo")

my_function("lima")
my_function("sima")
my_function("babu")

def my_function(*childs):
    print("first child name is "  +  childs[2])
my_function("lima","sima","babu")

f = open("file1.txt", "w")
f.write("I live in dhenkanal!")
f.close()


f = open("file1.txt", "r")
print(f.read())


f = open("file1.txt", "a")
f.write("my name is lima.\n I live in dhenkanal.!")
print(f.close())


f = open("file1.txt","r")
print(f.read())

x = "hellow"
if not type (x) is int:
    print(exception)