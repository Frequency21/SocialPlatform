#  Projekt: Social disctancing

<img src="./docs/logo.png" alt="Egy kib@#Đott madár" width="300"/>

## Projekt tagok

|     Név      |
| :----------: |
| Kiss Olivér  |
|  Burza Ralf  |
| Balogh Etele |
|   Svatlana   |

---

## Feladat leírás :pencil:

A feladat egy online közösségi oldal és a hozzá tartozó adatbázison alapuló szerver-kliens architektúrájú webalkalmazás megvalósítása. Ahol az adatbázis Oracle technológián nyugszik míg a webalkalmazást Angular és Node.js keretrendszerek segítségével készítjük el.

Az alkalmazás egy egyszerű regisztrációt és bejelentkezést követően lehetőséget nyújt arra, hogy új ismerősöket jelölhessünk be illetve meglévőekkel válthassunk üzenetet. Böngészhetünk nyilvános csoportok között melyekhez csatlakozhatunk. Csoportokat is alakíthatunk ahol hasonló érdeklődési körrel rendelkezők gyűlhetnek össze -- hobbi, iskola, munkahely. A profilunkat testreszabhatjuk, megadhatjuk a születési dátumunkat, nevünket, volt iskoláinkat, munkahelyeinket, lakhelyünket, hobbijainkat. Létrehozhatunk fényképalbumokat, melyeket rendszerezhetünk és nevet is adhatunk nekik. Illetve a hírfolyamon is elhelyezhetünk eseményeket, képeket, bejegyzéseket melyekre jöhetnek likeok illetve megjegyzések.

---
## Követelmény katalógus :book:
- Látogató tudjon megtekinteni nyilvános csoportokat, nyilvános bejegyzéseket (pl.: újságcikk, esemény)
- Még nem regisztrált emailcímmel lehessen regisztrálni, azt követően lehessen belépni emailcím / jelszó párossal
- A belépett felhasználó legyen képes
  - kijelentkezni
  - a saját profilját szerkeszteni (profilkép, adatok módosítása)
  - fényképalbumokat létrehozni
  - a saját hírfolyamát szerkeszteni (események, fényképek megosztása)
  - keresni nyilvános csoportok és felhasználók között
  - ismerősnek jelölni / jelöléseket elfogadni
  - üzenetet váltani ismerőssel
  - üzenetet váltani ismeretlennel (engedélykérések) :question:
  - csoportot létrehozni / csoporthívást elfogadni
  - a hírfolyam tartalmazza a csatlakozott csoportokhoz / visszaigazolt ismerősökhöz tartozó új bejegyzéseket
  - bejelentést tenni csoportokról vagy más felhasználókrol :question:
- Csoportok (nyilvános / privát)
  - az alapító küldhessen meghívókat
  - az alapító és az arra jogosultak adhassanak további rangokat (sima tag, csoport admin, moderátor, lelkes rajongó) :question::question::question:
  - lehessen kiválasztani, hogy az egyes rangú felhasználók neve milyen színnel jelenjen meg a komment szekciókban
- Az adminisztrátorok
  - láthassanak minden egyéb felhasználót és csoport bejegyzést (a privát üzeneteket ne)
  - tudjon csoportot vagy felhasználót törölni a rendszerből :cop:

---

|    Név    |
| :-------: |
|Kiss Olivér |
| Burza Ralf |
|Balogh Etele|
|  Svatlana  |

</center>

---
## Követelmény katalógus :fire:
- A látogató (még nem regisztrált, vagy be nem jelentkezett felhasználó) megtudjon tekinteni oldalakat
- A még nem regisztrált felhasználó tudjon regisztrálni, amennyiben már van fókja, be kell tudni jelentkezni
- Ha  már bejelentkezett, akkor ki is tudjon már
- A belépett felhasználók tudjanak keresni csoportok és a többi felhasználó között
- A felhasználók tudjanak csoportokhoz csatlakozni (ebben az esetben a csoport új bejegyzései megjelennek a hírfolyamukban)
- A felhasználók tudjanak csoportokat létrehozni.
- A felhasználók tudjanak "barátnak jelölést" végezni más felhasznáók felé
- A felhasználók tudjanak üzenetet küldeni egymásközött
- A felhasználók tudjanak bejelentést tenni csoportokról vagy más felhasználókrol (ilyen: "Néz már rá erre meg erre lesz szíves!") :question:
- Az Admin felhasználó láthasson minden egyéb felhasználót és csoport bejegyzést (a privát üzeneteket ne)
- Az Admin felhasználó tudjon csoportot vagy felhasználót törölni a rendszerből :cop:

