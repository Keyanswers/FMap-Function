
## A function in R to create maps with the option to use shapefiles.

This function provides a way to build maps, considering rivers and lakes. Six arguments are mandatory; however, there are enough options to customize the end product. This function can save you time even if you use all arguments.

Mandatory arguments
Lon1: The lower value of the x-axis.
Lon2: The higher value of the x-axis.
Lat1: The lower value of the y-axis.
Lat2: The higher value of the y-axis.

countries: You can set this argument to NULL if you don't know which country or countries to plot. The names and codes of the countries are available through the function iso3166.

Len: This is the length of scale bar.

The others arguments have default values. There are four limits to plot a seawater shape: x1, x2, y1, and y2. The values assigned must be lower or higher than their latitude and longitude values.  

TFont allows you to select a font letter. You can choose available fonts with fonts().
Considering rivers, lakes, seas, and oceans, different blue scales have been chosen for the color options. Alternatively, you can choose from the available options listed here:http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf.

* Col1: This is the color of the square area that represents the ocean or sea; it is also used for lakes and rivers provided by the maps and mapdata packages (the color chosen was dodgerblue).

* Col2: This is the color Color selected for the isobaths (the color chosen was lightsteelblue).

* Col3: This is the color used to fill the continental mass and coastal areas (the color chosen was lightyellow).

* Col4: This is the color that you select for the shapefiles.

The step argument allows you to specify the frequency for plotting isobaths, the default value is 150m. 

The arguments Lon3 and Lat3 are used to specify how longitude and latitude axes labels should appear in the chosen language. 

The arguments Line1 and line2 provide options for distances from the axes without being overwritten.

In the wind rose, the arguments rose1, rose2, and rcex have default values. For selecting another location, rose1 is the longitude value and rose2 is the latitude value (for this only are used two values).As a default, rcex is set to 0.6.

The following arguments of the scalebar have default values. In the case that you want to customize this: 
* You can choose either "bar" or "line" as the type (the default is "bar").
* Black and white rectangles are provided by divs (the default value is 4). 
* The text size is bcex (the default value is 0.7).
* The argument for the units is below (default is 'km').

The fill argument specifies the color of the shapefile polygons.

Note: The sphs argument is written outside the list of arguments for the function. This can be one shapefile or a list of shapefiles. Write an empty list when they aren't included like => sphs = list(). 

The mapdata package does not provide information on tributary rivers; therefore, this can be obtained from websites such as https://www.weather.gov/gis/Rivers and http://www.conabio.gob.mx/informacion/gis/.

Warnings: FMap will install the packages the first time you use it. After the packages are installed, the Microsoft fonts will be imported into R and you will see the following message:

```{r}         
       "Importing fonts may take a few minutes, depending on the number of fonts and the speed
        of the system. Continue? [y / n]"
```
You must type "y" and wait until the process is complete (this is required only the first time).

The click() function allows you to select where the scale bar should be placed, after that the map will be completed.                           

By using par(oma), you can set the border of a final figure; you'll only need to change the number after the plus sign to set the y-axis label.  
          

#### Examples without shapefiles and different fonts

* Longitude range 10E - 50E; Latitude range 18N - 61N
* Longitude range 76W - 32W; Latitude range 51N - 69N
* Longitude range 143W - 2E; Latitude range 33N - 75N
* Longitude range 163W - 150W; Latitude range 10N - 21N

```{r}
load("FMap.Rdata")
```
```{r}
x11()
sphs=list() # Empty list
par(oma=c(2,4,2,3)+1)
FMap(10,50,18,61,
     9,16,51,62,
      TFont="Sylfaen",
      countries=c(),
      col1="dodgerblue",col2="lightsteelblue",col3="lightyellow",
      step=800,
      Lon3="Longitudea",Lat3="Latitudea", line1=2,line2=3,
      rose1=46.5,rose2=58,rcex=0.45,
      len=500,type='bar',divs=4,below="Kilometroak",bcex=0.6)

dev.copy(device=jpeg,filename="Map1.jpeg",width=800,height=800)
dev.off()
```

```{r}
x11()
sphs=list() # Empty list
FMap(-76,-32,51,69,
     -78,50,-31,71,
     TFont="Lucida Console",
     countries=c(),
     col1="dodgerblue",col2="lightsteelblue",col3="lightyellow",
     step=500,
     Lon3="Longitude",Lat3="Latitude", line1=2,line2=3,
     rose1=-36,rose2=67.9,rcex=0.5,
     len=300,type='bar',divs=2,below="Kilomètres",bcex=0.6)
     
dev.copy(device=jpeg,filename="Map2.jpeg",width=800,height=800)
dev.off()
```

```{r}
x11()
sphs=list() # Empty list
par(oma=c(1.5,4,1.5,3)+1) # Here, the value after the plus sign set the y-axis label space 
FMap(-143,2,33,75,
     -144,32,3,76,
     TFont="Leelawadee UI Semilight",
     countries=c(),
     col1="dodgerblue",col2="lightsteelblue",col3="lightyellow",
     step=1200,
     Lon3="Longitudine",Lat3="Latitudine", line1=2,line2=3,
     rose1=-6.5,rose2=69,rcex=0.45,
     len=1000,type='bar',divs=4,below="Chilometri",bcex=0.5)

dev.copy(device=jpeg,filename="Map3.jpeg",width=800,height=800)
dev.off()
```

```{r}
x11()
sphs=list() # Empty list
FMap(-163,-150,10,21,
     -164,9,-149,22,
     TFont="Times New Roman",
     countries=c(),
     col1="dodgerblue",col2="lightsteelblue",col3="lightyellow",
     step=1500,
     Lon3="Longitud",Lat3="Latitud", line1=2,line2=3,
     rose1=-161.7,rose2=20,rcex=0.5,
     len=500,type='bar',divs=4,below="Kilómetros",bcex=0.5)

dev.copy(device=jpeg,filename="Map4.jpeg",width=800,height=800)
dev.off()
```


#### Examples with shapefiles and different fonts.

* Longitude range 5W - 35E; Latitude range 33N - 50N
* Longitude range 10W - 50E; Latitude range 33N - 75N

```{r}
sph1=readOGR("Abies_alba_plg.shp")# https://www.sciencedirect.com/science/article/pii/S2352340917301981 
sphs=list(sh1=map(sph1))

x11()
par(oma=c(2,4,2,3)+1) # Here, the value after the plus sign set the y-axis label space 
FMap(-5,35,33,50,
     -6,32,36,52,
     countries = c(),
     TFont = "Times New Roman",
     col1="dodgerblue",col2="lightsteelblue",col3="lightyellow",col4="red",
     step=1500,
     Lon3="Longitude",Lat3="Latitude",line1=2,line2=3,
     rose1=33,rose2=48,rcex=0.5,
     len=500, type="bar",divs=4,below="Kilometers",bcex=0.8,
     fill=TRUE)
```
##### If you need to show your stations

```{r}
df=data.frame(sta=letters[1:10],lon=runif(10,10,20),lat=runif(10,45,50)) # sampling sites simulated 

points(df$lon,df$lat,cex=3,pch=19,col="forestgreen")
text(df$lon,df$lat,df$sta,cex=1,pos=1,col="dodgerblue")

dev.copy(device=jpeg,filename="Map5.jpeg",width=800,height=800)
dev.off()
```
##### Another example using a shapefile. 
```{r}
sph=readOGR("railways.shp")# https://mapcruzin.com/free-europe-arcgis-maps-shapefiles.htm
sphs=list(sh=map(sph))

x11()
par(oma=c(2,4,2,3)+1) # Here, the value after the plus sign set the y-axis label space 
FMap(-10,50,33,75,
     -12,32,52,77,
     countries = c(),
     TFont = "Times New Roman",
     col1="dodgerblue",col2="lightsteelblue",col3="lightyellow",col4="firebrick",
     step=1500,
     Lon3="Longitude",Lat3="Latitude",line1=2,line2=3,
     rose1=40,rose2=72,rcex=0.8,
     len=500, type="bar",divs=4,below="Kilometers",bcex=0.5)

dev.copy(device=jpeg,filename="Map6.jpeg",width=800,height=800)
dev.off()
```
