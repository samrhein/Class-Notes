HashMap colorMap = new HashMap();

String files[];
String fileLeads[];
String fileDest[];
String fileType = ".png";

String colorsFile[];

String imagesPath = "maps/";
String terrPath = "terr/";

void setup(){
  //Clear the error.txt file
  File f = new File(sketchPath("")+"error.txt");
  if(f.exists())f.delete();
    
  //get list of files
  files = (new File(sketchPath(imagesPath))).list();
  
  try{
    //get list of leads to convert
    fileLeads = loadStrings("fileLeads.txt");
    //get the file type of the images
    fileType = loadStrings("fileType.txt")[0].toLowerCase();
    
    fileDest = loadStrings("fileDestination.txt");
    
    colorsFile = loadStrings("colorMap.txt");
    
    if(fileLeads == null || fileType == null || colorsFile == null || fileDest == null)throw new Exception();
    
  }catch(Exception e){
    //if there is a problem opening one of the files
    addError("Error reading 'fileLeads.txt', 'fileType.txt', 'fileDestination.txt', or 'colorMap.txt'");
    exit();
    return;
  }
  
  terrPath = fileDest[0].replace("%PATH%/",sketchPath(""));
  
  //create map for all colors for the game tiles
  //cycle through every line
  for(int i=0;i<colorsFile.length;i++){
    try{
      //find the first space
      int spIndex = colorsFile[i].indexOf(" ");
      //get the color as an int
      String colstr = colorsFile[i];
      colstr.trim();
      colstr=colstr.substring(1,spIndex);

      if(colstr.length()==6)colstr="ff"+colstr;
      else if(colstr.length()!=8)throw new Exception();
      int col = unhex(colstr);
      
      //get the character to output
      char val = (colorsFile[i].substring(spIndex+1,spIndex+2)).charAt(0);
      //add to the map
      colorMap.put(col,val);  
    }catch(Exception e){
      addError("Formatting error in colors.txt on line " + (i+1));
    }
  }
}

void draw(){
  //cycle through every file
  for(int i=0; files!=null && i < files.length; i++){
    //if is of the appropriate file type
    if(files[i].toLowerCase().indexOf(fileType) != -1){
      //cycle through every filename lead
      for(int j = 0 ; j < fileLeads.length; j++){
        if(files[i].indexOf(fileLeads[j])==0){
          println("Wrote " + ConvertMap(files[i]));
          break;
        }
      }
    }
  }
  exit();
}

String ConvertMap(String name){
  //load the image
  PImage im;
  im = loadImage(imagesPath + name);
  image(im,0,0);
  if(im==null){
    println("Image file " + name +" does not exist.");
    return null;
  }
  
  //cycle through the pixels and create a string based off of it
  String dataStr = "";
  im.loadPixels();
  for(int h = 0 ; h<im.height ; h++){
    for(int w = 0 ; w<im.width ; w++){
      //get the pixel color at this point
      Object c = colorMap.get(im.pixels[h*im.width + w]);
      
      //if there is a problem reading the pixel color
      if(c==null){
        addError("Error matching color #" + hex(color(im.pixels[h*im.width + w])).substring(2) + " from pixel (" + w + ", " +h + ") in file "+ name);
        
        return null;
      }
      dataStr+=c;      
    }
    dataStr+='\n';
  }
  
  //Finds the last period from the file extension
  int start = -1;
  while(name.indexOf(".", start+1) != -1){
    start = name.indexOf(".", start+1);
  }
  
  //Save out the data
  String[] dataLines = {dataStr};
  name = name.substring(0,start) + ".terr";
  
  //write to terrain files to the terr folder
  saveStrings(terrPath+name, dataLines);
  
  return name;
}

void addError(String e){
  String[] errorString;
       
  if(!(new File(sketchPath("")+"error.txt")).exists()){
    errorString = new String[1];
    errorString[0] = "";
  }else{
    errorString = loadStrings("error.txt");
    errorString[errorString.length-1] += '\n';
  }
  errorString[errorString.length-1] += "ERROR - " + month()+"/"+day()+"/"+ year()+ " " + hour() +":"+minute() +":"+second() + " - " + e;
  saveStrings(dataPath("../error.txt"),errorString);
  
  println(e);
}

