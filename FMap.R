FMap=function(Lon1,Lon2,Lat1,Lat2,
              x1,y1,x2,y2,
              TFont,countries,
              col1,col2,col3,col4,
              step,Lon3,Lat3,line1,line2,
              rose1,rose2,rcex,
              len,type,divs,bcex,below,
              fill){
  pck=c("mapdata","maps","extrafont","extrafontdb","raster","rgdal","sp","marmap")
  lpck=data.frame(installed.packages())
   
  if(length(pck[!pck %in% lpck$Package])>0){
    install.packages(c(pck[!pck %in% lpck$Package]))
    lapply(pck[1:7], require,character.only=TRUE)
  } else {
    lapply(pck[1:7], require,character.only=TRUE)
  }
  #
  ifelse(dim(lpck[lpck$Package=="Rttf2pt1" & lpck$Version=="1.3.8",])[2]>1
         ,require(Rttf2pt1),
         remotes::install_version("Rttf2pt1", version = "1.3.8"))
  ifelse(length(fonts())>0,print("Working on your map"),font_import())
  loadfonts(device="win", quiet=TRUE)

  # Bathymetry
  bath=marmap::getNOAA.bathy(Lon1,Lon2,Lat1,Lat2, resolution=1,keep=TRUE)
  TFont=par(family=ifelse(missing(TFont),"Arial",TFont))
  step = ifelse(missing(step),150,step)
  
  col1 = ifelse(missing(col1),"dodgerblue",col1)
  col2 = ifelse(missing(col2),"lightsteelblue",col2)
  col3 = ifelse(missing(col3),"lightyellow",col3)
  
  x1 = ifelse(missing(x1),Lon1-0.5, x1)
  x2 = ifelse(missing(x2),Lon2+0.5, x2)
  y1 = ifelse(missing(y1),Lat1-0.5, y1)
  y2 = ifelse(missing(y2),Lat2+0.5, y2)
  
  type = ifelse(missing(type),'bar',type)
  divs = ifelse(missing(divs),4, divs); 
  bcex = ifelse(missing(bcex),0.7, bcex);
  below = ifelse(missing(below),'km', below)
  
  rose1 = ifelse(missing(rose1),Lon1 + 0.95, rose1)
  rose2 = ifelse(missing(rose2),Lat2 - 0.8, rose2)
  rcex = ifelse(missing(rcex),0.6, rcex)
  
    
  # Map
  map('worldHires',countries,xlim=c(Lon1,Lon2),ylim=c(Lat1,Lat2),col="white")
  rect(x1,y1,x2,y2, border=col1, col=col1)
  # Bathymetric information
  plot(bath,add=TRUE,drawlabel=TRUE,deep=min(bath),shallow=max(bath),step=step,
       col=col2)
  # Final layers
  map('worldHires',countries,xlim=c(Lon1,Lon2),ylim=c(Lat1,Lat2),add=TRUE,fill=TRUE,
      col=col3)
  
  map('rivers',add=TRUE,col=col1)
  map('lakes',add=TRUE,fill=TRUE,col=col1)
  # Shapefiles
  lapply(sphs, map,add=TRUE,fill=ifelse(missing(fill),FALSE, TRUE),
         col=ifelse(missing(col4),print("Still working on your map"),col4))
  # Map conventions
  Lon3 = ifelse(missing(Lon3),"Longitude",Lon3)
  Lat3 = ifelse(missing(Lat3),"Latitude",Lat3)
  
  mtext(Lon3, 1,line=ifelse(missing(line1),2,line1),cex=1)
  mtext(Lat3, 2,line=ifelse(missing(line2),3.7,line2),cex=1)

  compassRose(rose1,rose2,cex=rcex)
  scalebar(len,xy=click(),type=type,divs=divs,cex=bcex,below)  
  degAxis(1)
  degAxis(2,las=1)
  box()
  par(TFont)
}
save(FMap,file="FMap.Rdata")
load("FMap.Rdata")
