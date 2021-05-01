/*
1)  mi collego al sito meteo.it per avere i dati meteo:
 dal momento che restituisce errore 403 creo una funzione
 che chiamo workaround per produrre un file contenente il testo
 da analizzare
 2)  analizzo il file inserendo i delimitatori
 3)  salvo una tabella con i valori ritrovati
 4)  definisco la parte grafica
 */


//-----------------------Importazione librerie necessarie----------------------- 
//-----------------------e definizione di alcune variabili-----------------------

//importo le librerie per la gestione della data
import java.text.SimpleDateFormat;
import java.util.*;

//definisco "oggi", "domani" e "dopodomani"
int giorno = int(new SimpleDateFormat("u").format(new Date()));

//inizializzo le variabili legate ai giorni della settimana
String today = "";
String tomorrow = "";
String dayAfterTomorrow = "";

//definisco l'array dei giorni della settimana
String giorniDellaSettimana[] = {"lunedì", "martedì", "mercoledì", "giovedì", "venerdì", "sabato", "domenica"};

// importo le librerie necessarie al funzionamento di htmlWorkaround()
import java.net.*;
import java.io.*;

//definisco la tabella che userò per visualizzare le condizioni meteo
Table table0;
Table table1;
Table table2;

//creo un array contenente le tabelle
Table[] table = {table0, table1, table2};

//definisco le variabili da inserire in tabella
int time;
String weatherCondition;
int speedMin;
int speedMax;
String direction;

PImage greenIcon;
PImage orangeIcon;
PImage redIcon;

//-----------------------SETUP-----------------------
void setup() {

  //size(360, 640);
  background(0);
  //background(219, 182, 156);  noStroke();

  //"riporto" il giorno 1 a 0 e così via per farlo coincidere con l'origine 
  //dell'array giorniDellaSettimana
  giorno = giorno - 1;

  //assegno alle variabili il valore calcolato usando giorniDellaSettimana
  today = giorniDellaSettimana[giorno];
  tomorrow = giorniDellaSettimana[(giorno + 1) % 7];
  dayAfterTomorrow = giorniDellaSettimana[(giorno + 2) % 7];

  //preparo la tabella
  for (int i = 0; i < 3; i++) {
    table[i] = new Table();

    //aggiungo le colonne
    table[i].addColumn("time");
    table[i].addColumn("weatherCondition");
    table[i].addColumn("speedMin");
    table[i].addColumn("speedMax");
    table[i].addColumn("direction");
  }

  //"chiamo" la funzione htmlWorkaround che genera il file da leggere
  htmlWorkaround();

  //chiamo la funzione di display delle icone
  prossimiGiorni(0);

  //rettangolo superiore
  rect(width/3, 0, 2*width/3, height/20);      

  //rettangolo inferiore
  rect(0, 19*height/20, width, 19*height/20);

  //eseguo il display del testo
  PFont ralewaySemiBold;
  ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/18);
  textFont(ralewaySemiBold);
  textAlign(CENTER);
  text("OGGI", width/6, height/25);
  fill(0);
  ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/18);
  textFont(ralewaySemiBold);
  text("DOMANI", width/2, height/25);
  ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/24);
  textFont(ralewaySemiBold);
  text("DOPODOMANI", 5*width/6, height/27);
  ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/18);
  textFont(ralewaySemiBold);
  text(today, width/2, height-width/36);
}


//-----------------------DRAW-----------------------
void draw() {
  noStroke();
  stroke(255);
  fill(255);

  //ralewaySemiBold = createFont("Raleway-SemiBold.ttf", 25);

  if (mousePressed == true && mouseY > 0 && mouseY < height/20) {
    if (mouseX > 0 && mouseX < width/3) {
      background(0);
      //background(219, 182, 156);
      //chiamo la funzione di display delle icone
      prossimiGiorni(0);

      //rettangolo superiore
      rect(width/3, 0, 2*width/3, height/20);      

      //rettangolo inferiore
      rect(0, 19*height/20, width, 19*height/20);

      //eseguo il display del testo
      PFont ralewaySemiBold;
      ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/18);
      textFont(ralewaySemiBold);
      textAlign(CENTER);
      text("OGGI", width/6, height/25);
      fill(0);
      ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/18);
      textFont(ralewaySemiBold);
      text("DOMANI", width/2, height/25);
      ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/24);
      textFont(ralewaySemiBold);
      text("DOPODOMANI", 5*width/6, height/27);
      ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/18);
      textFont(ralewaySemiBold);
      text(today, width/2, height-width/36);


      //domani
    } else if (mouseX > width/3 && mouseX < 2 * width/3) {
      background(0);
      //background(219, 182, 156);
      //chiamo la funzione di display delle icone
      prossimiGiorni(1);

      //rettangoli superiori
      rect(0, 0, width/3, height/20);
      rect(2*width/3, 0, width/3, height/20);      

      //rettangolo inferiore
      rect(0, 19*height/20, width, 19*height/20);

      //eseguo il display del testo
      PFont ralewaySemiBold;
      fill(0);
      ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/18);
      textFont(ralewaySemiBold);
      textAlign(CENTER);
      text("OGGI", width/6, height/25);
      fill(255);
      ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/18);
      textFont(ralewaySemiBold);
      text("DOMANI", width/2, height/25);
      fill(0);
      ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/24);
      textFont(ralewaySemiBold);
      text("DOPODOMANI", 5*width/6, height/27);
      ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/18);
      textFont(ralewaySemiBold);
      text(tomorrow, width/2, height-width/36);

      //dopodomani
    } else if (mouseX > 2 * width/3 && mouseX < width) {
      background(0);
      //background(219, 182, 156);
      //chiamo la funzione di display delle icone
      prossimiGiorni(2);

      //rettangolo superiore
      rect(0, 0, 2*width/3, height/20);

      //rettangolo inferiore
      rect(0, 19*height/20, width, 19*height/20);

      //eseguo il display del testo
      PFont ralewaySemiBold;
      fill(0);
      ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/18);
      textFont(ralewaySemiBold);
      textAlign(CENTER);
      text("OGGI", width/6, height/25);
      ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/18);
      textFont(ralewaySemiBold);
      text("DOMANI", width/2, height/25);
      fill(255);
      ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/24);
      textFont(ralewaySemiBold);
      text("DOPODOMANI", 5*width/6, height/27);
      ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/18);
      textFont(ralewaySemiBold);
      fill(0);
      text(dayAfterTomorrow, width/2, height-width/36);
    }
  }
}


//-----------------------htmlWorkaround() >> "aggira" l'errore 403-----------------------
void htmlWorkaround() {
  String[] weatherURLs = {"WEATHERWEBSITE.TODAY", "WEATHERWEBSITE.TOMORROW", "WEATHERWEBSITE.DAYAFTERTOMORROW"};

  for (int i = 0; i < weatherURLs.length; i++) {
    URL url;

    //
    try {
      // Create a URL object
      url = new URL(weatherURLs[i]);
      URLConnection conn = url.openConnection();
      conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB;     rv:1.9.2.13) Gecko/20101203 Firefox/3.6.13 (.NET CLR 3.5.30729)");
      // Read all of the text returned by the HTTP server
      BufferedReader in = new BufferedReader
        (new InputStreamReader(conn.getInputStream(), "UTF-8"));

      String htmlText;
      String myText = "";

      while ( (htmlText = in.readLine ()) != null) {
        myText = myText + htmlText;
      }
      loadData(myText, i);
    } 

    //Should be called once the website throws 403 back, case 1
    catch (MalformedURLException e) {
      println(e);
    } 

    //Should be called once the website throws 403 back, case 2
    catch (IOException e) {
      println(e);
    }
  }
}


//-----------------------loadData()-----------------------
void loadData(String myText, int j) {

  //genera una tabella 0 riferita alla data odierna
  //le ore e tutti gli altri campi sono pari a zero/vuoto
  if (j == 0) {
    for (int l = 0; l < hour(); l++) {
      TableRow newRow = table[j].addRow();
      newRow.setInt("time", l);
      newRow.setString("weatherCondition", "");
      newRow.setInt("speedMin", 0);
      newRow.setInt("speedMax", 0);
      newRow.setString("direction", "");
    }
  }

  //tolgo le parti non utili
  String testoDaAnalizzareUnitoRipulito = testoCompreso(myText, "<ul class=\"mb-24\">", "</ul>");

  //ricreo un array con i singoli slot orari contenenti le informazioni utili
  String[] slotOrari = split(testoDaAnalizzareUnitoRipulito, "</li>");

  //ore (time), condizioni meteo (weatherCondition), 
  //velocità minima e massima (
  for (int i = 0; i < slotOrari.length - 2; i++) {


    //trovo l'ora
    String delimitatoreInizio = "<time>";
    String delimitatoreFine = "</time>";
    //converto in int
    time = int(testoCompreso(slotOrari[i], delimitatoreInizio, delimitatoreFine));
    //aggiungo una fila alla tabella
    TableRow newRow = table[j].addRow();

    //inserisco il dato trovato
    newRow.setInt("time", time);

    //trovo la descrizione del meteo
    //prima limito l'ambito di ricerca per evitare doppioni
    delimitatoreInizio = "<figure>";
    delimitatoreFine = "</figure>";
    String descrizione = testoCompreso(slotOrari[i], delimitatoreInizio, delimitatoreFine);
    //poi estraggo la descrizione
    delimitatoreInizio = "alt=\"";
    delimitatoreFine = "\"/>";
    String weatherCondition = testoCompreso(descrizione, delimitatoreInizio, delimitatoreFine);

    //inserisco il dato trovato
    newRow.setString("weatherCondition", weatherCondition);

    //trovo velocità minima e massima del vento
    //prima limito l'ambito di ricerca per evitare doppioni
    delimitatoreInizio = "<p class=\"windInfoContainer\">";
    delimitatoreFine = "Km/h";
    String velMinMax = testoCompreso(slotOrari[i], delimitatoreInizio, delimitatoreFine);

    //splitto la stringa ottenuta per avere un array contenente le velocità in slot separati
    String[] velVento = split(velMinMax, "span>-<span ");

    //devo ridurre ulteriormente la stringa di velocità minima per evitare doppioni
    delimitatoreInizio = "span class=";
    delimitatoreFine = "/";
    String velMinPreliminare = testoCompreso(velVento[0], delimitatoreInizio, delimitatoreFine);

    delimitatoreInizio = "\">";
    delimitatoreFine = "<";
    int speedMin = int(testoCompreso(velMinPreliminare, delimitatoreInizio, delimitatoreFine));
    int speedMax = int(testoCompreso(velVento[1], delimitatoreInizio, delimitatoreFine));

    //inserisco i dati trovati
    newRow.setInt("speedMin", speedMin);
    newRow.setInt("speedMax", speedMax);

    //trovo la direzione
    //prima limito l'ambito di ricerca per evitare doppioni
    delimitatoreInizio = "<p class=\"windDirectionName\">";
    delimitatoreFine = ".svg";
    String direzioneVento = testoCompreso(slotOrari[i], delimitatoreInizio, delimitatoreFine);
    //poi estraggo la direzione
    delimitatoreInizio = "_wind_";
    delimitatoreFine = "_";
    String direction = testoCompreso(direzioneVento, delimitatoreInizio, delimitatoreFine);

    //inserisco il dato trovato
    newRow.setString("direction", direction);
  }

  saveTable(table[j], "tabella" + j + ".csv");
}

//-----------------------testoCompreso >> alimenta loadString()-----------------------
String testoCompreso(String s, String inizio, String fine) {
  int start = s.indexOf(inizio);
  if (start == -1) {
    return "";
  };

  start += inizio.length();
  int end = s.indexOf(fine, start);
  if (end == -1) {
    return "";
  }

  return s.substring(start, end);
}

//-----------------------prossimiGiorni()-----------------------
//-----------------------oggi = 0, domani = 1 e dopodomani = 2-----------------------
void prossimiGiorni(int n) {

  imageMode(CENTER);

  //carico le immagini delle icone
  greenIcon = loadImage("icon-green-mod.png");
  orangeIcon = loadImage("icon-orange-mod.png");
  redIcon = loadImage("icon-red-mod.png");

  //eseguo il display della grafica
  //definisco le distanze tra i cerchi
  int x = width/7;
  int y = height/5;
  //creo un contatore per le ore
  int z = 0;

  //uso un doppio array per distribuire gli slot con le informazioni
  for ( int j = 0; j < 4; j++) {
    for (int i = 0; i < 6; i++) {

      //voglio mostrare icone diverse a seconda
      //della presenza di pioggia
      //della velocità del vento

      //cerco all'interno di weatherCondition se è prevista pioggia
      String toBeSearched = table[n].getString(z, "weatherCondition");
      String searchOne = "pio";
      String searchTwo = "temp";

      int indexOne = toBeSearched.indexOf(searchOne);
      int indexTwo = toBeSearched.indexOf(searchTwo);      

      //ottengo la velocità media
      float speedMin = table[n].getInt(z, "speedMin");
      float speedMax = table[n].getInt(z, "speedMax");
      float averageWindSpeed = (speedMin + speedMax)/2;

      //non voglio bordi attorno alle icone
      noStroke();

      //stabilisco le condizioni per le icone
      //per prima cosa escludo le ore precedenti a quella attuale
      if (averageWindSpeed == 0) {
        fill(0);
       
      //poi,

      //se è prevista pioggia
      } else if ((indexOne != -1) || (indexTwo != -1)) {
        //icona vuota con goccia di pioggia
        fill(255);
        circle(x, y, width/9);
        fill(32, 0, 255);
        triangle(x - width/90, y + width/180, x + width/90, y + width/180, x, y - width/45);
        circle(x, y + width/120, width/40);

        //se il vento è maggiore di 24km/h
      } else if (averageWindSpeed >= 24) {
        //cerchio rosso
        //fill(255, 0, 0);
        //circle(x, y, width/9);
        image(redIcon, x, y, width/9, width/8);
        //se il vento è compreso tra 19 e 24hm/h
      } else if ((19 < averageWindSpeed) && (averageWindSpeed < 24)) {
        //cerchio arancio
        //fill(255, 128, 0);
        //circle(x, y, width/9);
        image(orangeIcon, x, y, width/9, width/8);

        //se il vento è minore di 19km/h
      } else {
        //cerchio verde
        //fill(0, 255, 0);
        //circle(x, y, width/9);
        image(greenIcon, x, y, width/9, width/8);
      }
      fill(255);

      if (averageWindSpeed != 0) {

        //creo il font per mostrare le ore
        PFont ralewaySemiBold;
        ralewaySemiBold = createFont("Raleway-SemiBold.ttf", width/18);
        //uso il font per creare il testo
        textFont(ralewaySemiBold);
        textAlign(CENTER);
        //creo il testo utilizzando il dato specifico della tabella
        text(table[n].getString(z, "time"), x, y - width/12);

        //creo il font per mostrare la direzione del vento
        PFont raleway;
        raleway = createFont("Raleway-SemiBoldItalic.ttf", width/24);
        //uso il font per creare il testo
        textFont(raleway);
        textAlign(CENTER);
        //creo il testo utilizzando il dato specifico della tabella
        text(table[n].getString(z, "direction") + "\n" + table[n].getInt(z, "speedMin") + "-" + table[n].getInt(z, "speedMax"), x, y + width/9);
      }

      x += width/7;
      z++;
    }

    x = width/7;
    y += height/5;
  }
}
