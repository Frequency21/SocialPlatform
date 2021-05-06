# Social Distancing

---

## Projekt tagok

|     Név      |
| :----------: |
| Kiss Olivér  |
|  Burza Ralf  |
| Balogh Etele |

---

## Feladat leírás

A feladat egy online közösségi oldal és a hozzá tartozó adatbázison alapuló szerver-kliens architektúrájú webalkalmazás megvalósítása. Ahol az adatbázis Oracle technológián nyugszik míg a webalkalmazást Angular és Node.js keretrendszerek segítségével készítjük el.

Az alkalmazás egy egyszerű regisztrációt és bejelentkezést követően lehetőséget nyújt arra, hogy új ismerősöket jelölhessünk be illetve meglévőkkel válthassunk üzenetet. Böngészhetünk csoportok között melyekhez csatlakozhatunk. Csoportokat is alakíthatunk, ahol hasonló érdeklődési körrel rendelkezők gyűlhetnek össze -- hobbi, iskola, munkahely. A profilunkat testreszabhatjuk, megadhatjuk a születési dátumunkat, nevünket, volt iskoláinkat, munkahelyeinket, lakhelyünket, hobbijainkat. Létrehozhatunk fényképalbumokat, melyeket rendszerezhetünk és nevet is adhatunk nekik. Illetve a hírfolyamon is elhelyezhetünk eseményeket, képeket, bejegyzéseket melyekre jöhetnek likeok illetve megjegyzések.

---
## Követelmény katalógus

- **Látogató** tudjon megtekinteni csoportokat és azok nyilvános bejegyzéseit, illetve más felhasználók nyilvános bejegyzéseit (pl.: újságcikk, esemény)
- Még nem regisztrált emailcímmel lehessen regisztrálni, azt követően lehessen belépni emailcím / jelszó párossal
- A belépett **felhasználó** legyen képes
  - kijelentkezni
  - a saját profilját szerkeszteni (profilkép, adatok módosítása)
  - **fényképalbum**okat létrehozni:
    - lehessen a képeket **kategorizálni**
    - kategóriáknak legyen neve
  - a saját **hírfolyam**át szerkeszteni (események, fényképek megosztása -- **poszt**olás)
  - keresni **csoport**ok és felhasználók között
  - ismerősnek jelölni / jelöléseket elfogadni
  - **üzenet**et váltani ismerőssel
  - ismerős hírfolyamán bejegyzést elhelyezni (posztolás) (pl.: születésnapi felköszöntés)
  - csoportot létrehozni / **csoporthívás**t elfogadni
  - **bejelentés**t tenni csoportokról vagy más felhasználókrol
- Csoportok (minden csoport nyilvános, látható hogy létezik)
  - egy felhasználó hozza létre, ő lesz a tulaj
  - a tulaj és az arra jogosultak adhassanak további rangokat (sima tag, csoport admin, moderátor, lelkes rajongó)
  - lehessen kiválasztani, hogy az egyes rangú felhasználók neve milyen színnel jelenjen meg a **komment** szekciókban
  - bárki beléphet, viszont meghívni is lehet felhasználókat
  - a posztok alapértelmezetten csoport láthatóságúak, viszont a tulaj nyilvánossá teheti
- Az **adminisztrátor**ok
  - tudjon csoportot vagy felhasználót törölni a rendszerből

### Részletezések
Posztolni csoport vagy felhasználó hírfolyamába lehet. A poszt láthatóságáról a közzétételkor dönthet a felhasználó,
alapértelmezetten nem nyilvános. Ez azt jelenti, hogy:
- csoport esetében, a posztot csak a csoport tagjai látják
- felhasználó esetében a posztot, csak a hírfolyam tulajdonosa és közvetlen ismerősei láthatják.

A posztokhoz tartozhatnak kommentek, bárki hagyhat kommentet aki láthatja a posztot.

---

## Adatfolyam diagram

### 1. szint
kép helye

### 2. szint
kép helye

---

## Egyed modell

---

## Egyed-kapcsolat diagramm

---

## Egyed-kapcsolat leképezés

---

## Adattáblák leírása

**Nevtipus**: A későbbi táblákban használt névtípus
![NEVTIPUS tablazat kibontasa](./Tablazatkibontas/NEVTIPUS.png)


**ERTEKELES**: A későbbi táblákbna használt értékelés típus
![ERTEKELES tablazat kibontasa](./Tablazatkibontas/ERTEKELES.png)

**Felhasznalo**: Az alkalmazás felhasználóit tartalmazó tábla
![Felhazsnalo tablazat kibontasa](./Tablazatkibontas/Felhasznalo.png)

**Csoport**: Az alkalmazás csoportjait tartalmazó tábla
![Csoport tablazat kibontasa](./Tablazatkibontas/Csoport.png)

**Poszt**: A felhasználók által létrehozható posztokat tartalmazó tábla
![Poszt tablazat kibontasa](./Tablazatkibontas/Poszt.png)

**Komment**: A Posztokhoz fűzhető kommenteket tartalmazó tábla
![Komment tablazat kibontasa](./Tablazatkibontas/Komment.png)

**Uzenet**: A felhasználók egymásnak küldött üzeneteit tartalmazó tábla
![Uzenet tablazat kibontasa](./Tablazatkibontas/Uzenet.png)

**Meghivas**: A csoportokba történő meghívásokat tartalmazó tábla
![Meghivas tablazat kibontasa](./Tablazatkibontas/Meghivas.png)

**Tagja**: A csoportok tagjait számontartó tábla
![Tagja tablazat kibontasa](./Tablazatkibontas/Tagja.png)

**Ismeros**: Az ismerősi kapcsolatokat számontartó tábla
![Ismeros tablazat kibontasa](./Tablazatkibontas/Ismeri.png)

**Kategoria**: A fényképekhez létrehozható kategóriákat tartalmazó tábla
![Kategoria tablazat kibontasa](./Tablazatkibontas/Kategoria.png)


**Kep**: A felhasználók által feltöltött fényképek elérési útvonalait tartalmazó tábla
![Kep tablazat kibontasa](./Tablazatkibontas/Kep.png)


---

## Szerep funkció mátrix

![szerep funkció mátrix](./szerep-funkcio-matrix.png)