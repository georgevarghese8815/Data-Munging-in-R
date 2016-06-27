
# ======================== data.table cheat sheet 

# General form: DT[i, j, by] -----> read as -----> "Take DT, subset rows using i, then calculate j grouped by by"

DT <- data.table(V1=c(1L,2L),
                 V2=LETTERS[1:3],
                 V3=round(rnorm(4),4),
                 V4=1:12)



# SUBSETTING ROWS USING i =============================
DT[3:5,]
DT[ V2 == "A"]
DT[V2 %in% c("A", "C")]



# MANIPULATING ON COLUMNS IN j ========================

DT[, V2]              #Column V2 is returned as a vector.
DT[, .(V2)]           #Column V2 is returned as a data.table.

DT[, .(V2,V3)]        #Columns V2 and V3 are returned as a data.table.
DT[, sum(V1)]         #Returns the sum of all elements of column V1 in a vector.
DT[,.(sum(V1),sd(V3))]    #Returns the sum of all elements of column V1 and the standard deviation of V3 in a data.table.

DT[, .(Aggregate = sum(V1), Sd.V3 = sd(V3))]    #The same as above, but with new names.

DT[, .(V1, Sd.V3 = sd(V3))]       #Selects column V1, and compute std. dev. of V3, which returns a single value and gets recycled.


#Multiple expressions can be wrapped in curly braces.
DT[,{print(V2)
  plot(V3)
  NULL}]            #Print column V2 and plot V3.



# DOING J BY GROUP ====================================

DT[,.(V4.Sum = sum(V4)),by=V1]
DT[,.(V4.Sum = sum(V4)),by=.(V1,V2)]

DT[,.(V4.Sum = sum(V4)),by=sign(V1-1)]
DT[,.(V4.Sum = sum(V4)),by=.(V1.01 = sign(V1-1))]

DT[1:5,.(V4.Sum = sum(V4)),by=V1]
DT[,.N,by=V1]                             #Count the number of rows for every group in V1.



# ADDING/UPDATING COLUMNS BY REFERENCE IN J USING ':=' =======================
DT[, V1 := round(exp(V1),2)]
DT[, c("V1","V2") := list(round(exp(V1),2), LETTERS[4:6])]
DT[, ':=' (V1 = round(exp(V1),2), V2 = LETTERS[4:6])][]           #Another way to write the same line as
                                                       # above this one, but easier to write comments side-by-side. Also, when [] is
                                                       # added the result is printed to the screen.

DT[, V1 := NULL]              # Removes column V1
DT[, c("V1","V2") := NULL]    # Removes column V1 and V2

Cols.chosen = c("A","B")      
DT[, Cols.chosen := NULL]     # Watch out: this deletes the column with column name Cols.chosen. 
DT[, (Cols.chosen) := NULL]   # Deletes the columns specified in the variable Cols.chosen (V1 and V2).



# INDEXING AND KEYS ====================================

setkey(DT,V2)
DT["A"]                       # Returns all the rows where the key column has the value A.
tables()                      # Returns all the rows where the key column (V2) has the value A or C
DT[c("A","C")]                # Returns all the rows where the key column (V2) has the value A or C.

DT["A", mult ="first"]        # Returns first row of all rows that match the value A in the key column (V2)
DT["A", mult ="last"]         # Returns last row of all rows that match the value A in the key column (V2).

DT[c("A","D")]
DT[c("A","C"), sum(V4)]

DT[c("A","C"), sum(V4), by=.EACHI]

setkey(DT,V1,V2)
DT[.(2,"C")] 
DT[.(2, c("A","C"))]



# ADVANCED DATA TABLE OPERATIONS =============================
# Go through the pdf to understand the code.

DT[.N-1]                  # Returns the penultimate row
DT[,.N]                   # Returns the number of rows

DT[, print(.SD), by=V2] 
DT[, .(num = .N), by=V2]
DT[,.SD[c(1,.N)], by=V2]
DT[, lapply(.SD, sum), by=V2]

DT[, lapply(.SD,sum), by=V2,.SDcols = c("V3","V4")]


