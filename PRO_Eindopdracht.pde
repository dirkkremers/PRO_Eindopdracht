//Dataset:
    //Bron: http://www.weeronline.nl/Europa/Nederland/Schijndel/4058658

//Processing functies:
    //Bron: Lessen Processing
    //Bron: Boek Getting Started With Processing - Casey Reas & Ben Fry
    //Bron: http://www.processing.org/

PFont opensans;
Table table;

String[] maand = new String[0];
float[] min = new float[0];
float[] max = new float[0];

int[] grafiekX = { -5, 0, 5, 10, 15, 20, 25 };
int[] y = { 280, 266, 226, 183, 142, 112, 94, 95, 128, 180, 236, 271 };
int[] yy = { 335, 331, 311, 291, 256, 228, 207, 211, 233, 266, 298, 324 };

void setup() {
  size(870, 475);
  smooth();
  fill(RGB);

  table = loadTable("datasetx10.csv", "header");
  opensans = loadFont("OpenSans-14.vlw");
}

void draw() {
  //println(mouseX, mouseY);
  fill(#777777);
  background(255);

  for (int i=0; i<max.length; i++) {

    if (mouseX >= (150+(50 * i)) && mouseX <= (170 +(50 * i)) && mouseY >= y[i] && mouseY <= yy[i]) {
      fill (#f28900);
      text(" " + (max[i]/10) + "°", 150+(50 * i), 420); 
      text(" " + (min[i]/10) + "°", 150+(50 * i), 440);
      text("Max. temp.", 60, 420);
      text("Min. temp.", 60, 440);
      fill (#777777);
    }
  }

  textSize(16);
  text("De temperatuur in Schijndel in 2014*", 100, 30); 
  textSize(10);
  text("*okt., nov. en dec. zijn voorspellingen", 100, 45);
  textSize(12);
  text("Bron: Weeronline.nl", 615, 30);

  for (int i=0; i<grafiekX.length; i++) {
    stroke(#b3b3b3);
    strokeWeight(1.5);
    line(140, (325-(grafiekX[i]*10)), 730, (325-(grafiekX[i]*10)));

    text(grafiekX[i] + " °", 100, (325-(grafiekX[i]*10)));
  }

  for (int i=0; i<maand.length; i++) {
    textSize(12);
    text(" " + (maand[i] + "."), (150+(50 * i)), 395);

    if (mouseX >= (150+(50 * i)) && mouseX <= (170 +(50 * i)) && mouseY >= y[i] && mouseY <= yy[i]) {
      fill(255); 
      noStroke();
      rect((150+(50 * i)), 380, 35, 20);
      fill(#f28900);
      text(" " + (maand[i] + "."), (150+(50 * i)), 395);
      fill(#777777);
    }
  }

  maand = new String[0];
  min = new float[0];
  max = new float[0];

  for (TableRow row : table.rows ()) {
    maand = append(maand, row.getString("maand"));
    min = append(min, row.getInt("min"));
    max = append(max, row.getInt("max"));
  }

  for (int i=0; i<maand.length; i++) {   
    fill (#f28900);
    noStroke();   
    rect((150+(50 * i)), (325-((max[i]*10)/10)), 20, (((max[i]/10)-(min[i]/10))*10));
  }
}

