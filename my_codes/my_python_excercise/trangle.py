from cgi import print_form


for i in range(1,5):
    for j in range(1,i+1):
        print('*', end ='')
    print('\n')        

for i in range(5,0,-1):
    for j in range(1,i+1):
        print('*', end ='')
    print('\n')        

for i in range(1,6):
    for k in range(1,6-i):
        print("_", end = "")  
    for j in range(1,i+1):
        print("*", end ="")
    print("\n")      

for i in range(5,0,-1):
    for k in range(1,6-i):
        print("_", end ="")
    for j in range(1,i+1):
        print("*", end ="")
    print("\n")    

for i in  range(1,5):
    for j in range(1,5):
        print("*", end ="")
    print()    


for i in range(0,6):
    for k in range(1,6-i):
        print('_',end ='')
    for j in range(1,(2*i+1)+1):
        print('&', end ='')
    print('\n')
      
for i in range(5,0,-1):
    for k in range(1,5-i):
        print("_", end ="")
    for j in range(1,(2*i-1)+1):
        print("&", end ="")
    print("\n")      

for i in range(1,6):
    for k in range(1,4):
        print(" ", end ="")
    for j in range(1,6):
        print("*", end ="")
    print()  

for i in range(0,6):
    for k in range(1,6-i):
        print(" ", end ="")
    for j in range(1,(2*i+1)+1):
        print("*", end ="")
    print("\n")         
for i in range(0,6):
    for j in range(1,6-i):
        print(' ', end ="")
    for j in range(1,(2*i+1)+1):
        print("*", end ="")
    print("\n")     
for i in range(1,5):
    for k in range(1,4):
        print(" ", end ="") 
    for j in range(1,5):
        print("*", end ="")   
    print("\n")            