#arrange function in dplyr
data<- data.frame(x1= 1:6,
                  x2= rnorm(1:6),
                  x3= c("A", "C", "D", "B", "E", "F"))
data
#in the out put you can easily observe that the order is not there in the column x3 and x2
# to get the arrange this there is a function offered in dplyr package of tidyverse called arrange()
# to use install tidyverse or dplyr package
install.packages("tidyverse")
library(tidyverse)
data<-arrange(data,x3)
data<-arrange(data, x2)
#now you can observe both column x2 and x3 following a order after using the arrange function on the
#----------------------------|----------------|--------------------------------------------------------
# pipe (%>%) operator in dplyr package
# pipe operators allow to chain multiple operations together
# taking an example with the inbuilt data set in "r" called mtcars
head(mtcars)
result<- mtcars%>%  # store the data set to new vector
  filter(mpg > 20)%>%  # filter the column "mpg" where the value is greater than 20
  select(mpg, cyl, hp)%>% # select the specified cols
  group_by(cyl)%>% # group the data by "cyl" variable
  summarise(mean_hp= mean(hp)) # calculates the the mean of the horsepower
view(result) 
# using filter function of dplyr to remove na from data frame 
d <- data.frame(
  x= 1:9,
  y = c("a", "b", "c", NA, NA, NA, "g", NA, "h"),
  z = rnorm(9)
)
# using filter function 
result_2 <- d %>%
  filter(!is.na(y)) # filtering out the non NA values from the data
view(result_2)
# now lets play with some more dplyr functions:
# select(), starts_with(),-starts_with,  contain(), matches()
#lets use the same data frame "d"
res<- d%>%
  select(z) #selecting the specific col
res_1<- d%>%
  select(1,3) # selecting multiple col using their index numb
e <- iris
head(e)
res_2<- e%>%
  select(starts_with("sep")) #will select the heading which starts with the specified words, in this case its "sep"
head(res_2)
res_2_1<- e%>%
  select(-starts_with("sep")) # will select only cols who does not have specified key words as their is negative sign (-) before the function you can also use "!" which indicates not
head(res_2_1)
res_3<- e%>%
  select(contains("et")) # same as the above function in this also you can use negative sign (-) to do its opposite
head(res_3)
res_4<- e%>%
  select(matches("et")) # same as the above function in this also you can use negative sign (-) to do its opposite
head(res_4)
# now lets jump into another very important functions in dplyr package
# mutate() and transmute()
head(e) # using the same database
res_0<- e%>%
  mutate(avg = (Sepal.Length + Petal.Width)/2)# this function will add new col called "avg" with avg between the two specified cols 
head(res_0)
res_0_1<- e%>%
  transmute(avg = (Sepal.Length + Petal.Width)/2) # in this function it will do the same job but return only newly created column
head(res_0_1)
# summarise() function of dplyr
head(e)
  summarise(e, mean= mean(Sepal.Length)) # will calculate the mean of the specified col
  summarise(e, md= median(Sepal.Length))# will calculate the median of the specified col
  summarise(e, min= min(Sepal.Length))# will calculate the minimum value of the specified col
  summarise(e, mx= max(Sepal.Length))# will calculate the maximum of the specified col
# sample_n() and sample_frac() function in dplyr
  head(e)
  sample_n(e, 5)  # will take the random sample specimen from the specified data frame and no. of rows
  sample_frac(e, 0.2)  #will print the random sample specimen but only the given percentage of the rows
  #-----|------------------|-----------------------|--------------------------------------|----------------|
  #lets jump into some practice question 
  # I'm gonna use inbuilt data set "iris" for practice
  #----------------------------------------------------|
  # 1st) question: Calculate the difference between the maximum and minimum values of Sepal.
  #Length for each species.
  #Also, add a column that calculates the range (max - min) for Petal.Length for each species.
 iris%>% 
   group_by(Species)%>%
   summarise(
     Sepal.Length.range = max(Sepal.Length) - min(Sepal.Length),
     Petal.Length.range = max(Petal.Length) - min(Petal.Length)
   )
 #---------------------------------------------------------------
 #Q2: Create a new column Sepal.Type based on the following conditions:
 #If Sepal.Length > 5.5, set Sepal.Type to "Large", otherwise set it to "Small"
 iris%>%
   mutate(
     Sepal.Type = if_else(Sepal.Length>5.5, "Large", "Small"))
 
# Q3: Use dplyr to filter the iris dataset where:
 #  Sepal.Length > 5.5
 #Petal.Length > 3.0
 #The species is either "setosa" or "virginica"
 iris%>%
   filter(Sepal.Length>5.5 & Petal.Length>3.0 & (Species == 'setosa' | Species== 'virginica'))
 
#Q4: For each species, calculate the following:
 #  Mean of Sepal.Length
 #Median of Petal.Width
 #Standard deviation of Sepal.Width
 iris%>%
   group_by(Species)%>%
   summarise(mean = mean(Sepal.Length),
             md = median(Petal.Length),
             std=sd(Sepal.Width))
#Q5: For each species, extract the top 3 rows with the highest Sepal.Length  
  iris%>%
    group_by(Species)%>%
    arrange(desc(Sepal.Length))%>%
    slice_head(n = 3)
 # Q5: Create two new columns in the iris dataset:
  #  Sepal.Ratio (calculated as Sepal.Length / Sepal.Width)
  #Petal.Ratio (calculated as Petal.Length / Petal.Width)
  #Then, filter the dataset to show only rows where:
  #Sepal.Ratio > 2.0 and Petal.Ratio < 3.0    
iris%>%
  mutate(
    Sepal.ratio = Sepal.Length/Sepal.Width,
    Petal.ratio = Petal.Length/Petal.Width)%>%
  filter(Sepal.ratio >2.0 & Petal.ratio<3.0)
#Q7: Calculate the moving average of Sepal.Length
#over a rolling window of 3 observations.
install.packages("zoo")
library(zoo)
iris%>%
  mutate(roll_avg = zoo::rollmean(Sepal.Length, 3,fill = NA, align = "right"))
head(iris)
#Q8: Rank the rows within each species based on Petal.Length 
#in descending order 
#and create a new column Petal.Rank that shows the rank.
iris%>%
  group_by(Species)%>%
  mutate(Petal.Rank = dense_rank(desc(Petal.Length)))
#Q9: Suppose you have a second dataset 
# with columns Species and Region. 
#Perform a left join with the iris dataset 
#to attach the Region to each row based on the Species.
additional_data<- data.frame(Species = c("setosa", "versicolor", "virginica"),
                             region = c("North", "South", "East"))
iris%>%
  left_join(additional_data, by = "Species")
#Q10: Create a new column Petal.Category 
#based on the following conditions:
#If Petal.Length < 2, categorize as "Short".
#If Petal.Length >= 2 and Petal.Length < 5, categorize as "Medium".
#If Petal.Length >= 5, categorize as "Long".
iris%>%
   mutate(Petal.category =
            case_when(
              Petal.Length < 2 ~ "Short",
              Petal.Length >= 2 & Petal.Length < 5 ~ "Medium",
              Petal.Length >= 5 ~ "Long"
            ))

