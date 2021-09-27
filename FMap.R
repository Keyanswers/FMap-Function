
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
  ifelse(dim(lpck[lpck$Package=="Rttf2pt1" & lpck$Version=="1.3.8",])[2]>1
       ,require(Rttf2pt1),
       remotes::install_version("Rttf2pt1", version = "1.3.8"))
  #
  ifelse(length(fonts())>0,print("working on your map"),font_import())
  loadfonts(device="win", quiet=TRUE)
  
  # Bathymetry
  bath=marmap::getNOAA.bathy(Lon1,Lon2,Lat1,Lat2, resolution=1,keep=TRUE)
  TFont=par(family=TFont)
  # Map
  map('worldHires',countries,xlim=c(Lon1,Lon2),ylim=c(Lat1,Lat2),col="white")
  rect(x1,y1,x2,y2, border=col1, col=col1)
  # Bathymetric information
  plot(bath,add=TRUE,drawlabel=TRUE,deep=min(bath),shallow=max(bath),step=step,col=col2)
  # Final layers
  map('worldHires',countries,xlim=c(Lon1,Lon2),ylim=c(Lat1,Lat2),add=TRUE,fill=TRUE,col=col3)
  map('rivers',add=TRUE,col=col1)
  map('lakes',add=TRUE,fill=TRUE,col=col1)
  # Shapefiles
  lapply(sphs, map,add=TRUE,fill=ifelse(missing(fill),FALSE, TRUE),col=ifelse(missing(col4),print("still working on your map"),col4))
  # Map conventions
  mtext(Lon3, 1,line=ifelse(missing(line1),1,line1),cex=1)
  mtext(Lat3, 2,line=ifelse(missing(line2),1,line2),cex=1)
  
  compassRose(rose1,rose2,cex=rcex)
  scalebar(len,xy=click(),type,divs,
           cex=bcex,below)
  
  degAxis(1)
  degAxis(2,las=1)
  box()
  par(TFont)
}
save(FMap,file="FMap.Rdata")
load("FMap.Rdata")
