coisas = {}
table.insert(coisas, 1)
table.insert(coisas, 2)
table.insert(coisas, 3)
table.insert(coisas, 4)
table.insert(coisas, 5)

table.remove(coisas, 1)
table.remove(coisas, 1)
table.remove(coisas, 1)
table.remove(coisas, 1)
table.remove(coisas, 1)

print(coisas[10000])
print(#coisas)