
## A function in R for creating maps with the option to use shapefiles.

This function provides a way to create maps considering rivers and lakes. Seven arguments are mandatory; however, there are enough options to customize the final product. This function can save you time even if you use all the arguments.

Mandatory arguments:

* sphs: A list of shapefiles; the empty list is required.
* Lon1: The lower value of the x-axis.
* Lon2: The higher value of the x-axis.
* Lat1: The lower value of the y-axis.
* Lat2: The higher value of the y-axis.
* countries: You can set this argument to NULL if you don't know which country or countries to plot. The names and codes of the countries are available through the function iso3166.
* Len: The length of the scale bar.
Other arguments (with default values):

* x1, x2, y1, y2: Limits to plot a seawater shape.

* TFont: Select a font letter. Choose available fonts with fonts().
* Col1: Color of the square area representing the ocean or sea, also used for lakes and rivers provided by the maps and mapdata packages (default is dodgerblue).
* Col2: Color selected for the isobaths (default is lightsteelblue).
* Col3: Color used to fill the continental mass and coastal areas (default is lightyellow).
* Col4: Color selected for the shapefiles.
* step: Frequency for plotting isobaths; default value is 150m.
* Lon3 and Lat3: Specify how longitude and latitude axes labels should appear in the chosen language.
* Line1 and Line2: Options for distances from the axes without being overwritten.

In the wind rose, the arguments rose1, rose2, and rcex have default values. For selecting another location, rose1 is the longitude value and rose2 is the latitude value (only two values are used). As a default, rcex is set to 0.6.

* Scalebar arguments with default values: type ('bar' or 'line'), divs (number of black and white rectangles; default is 4), bcex (text size; default is 0.7), and below (units; default is 'km').
* fill: Color of the shapefile polygons.
  
Note: The sphs argument is written outside the list of arguments for the function. This can be one shapefile or a list of shapefiles. Write an empty list when they aren't included like sphs = list().

The mapdata package does not provide information on tributary rivers; therefore, this can be obtained from websites such as https://www.weather.gov/gis/Rivers and http://www.conabio.gob.mx/informacion/gis/.

Warnings: FMap will install the packages the first time you use it. After the packages are installed, the Microsoft fonts will be imported into R, and you will see the following message:```{r}         
       "Importing fonts may take a few minutes, depending on the number of fonts and the speed
        of the system. Continue? [y / n]"
```
You must type 'y' and wait until the process is complete (this is required only the first time).

The click() function allows you to select where the scale bar should be placed; after that, the map will be completed.

By using par(oma), you can set the border of the final figure; you'll only need to change the number after the plus sign to set the y-axis label
          

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


#### EExamples with shapefiles and various fonts.

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
##### If you need to display your stations on the map.

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
