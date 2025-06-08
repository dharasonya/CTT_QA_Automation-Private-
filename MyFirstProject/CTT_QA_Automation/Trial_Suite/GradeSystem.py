grade=int(input("Enter Grade : "));
name="Sonya"
if(grade>=90):
    print("Grade A")
elif(grade <90 and grade>=80):
    print ("Grade B")
elif(grade <80 and grade>=70):
    print ("Grade C")
else:
    print ("Grade D")

#Nesting of If Loops

if(grade==90):
    if(name=="Sonyas"):
        print ("Topper");
    else:
        print("Invalid Student")