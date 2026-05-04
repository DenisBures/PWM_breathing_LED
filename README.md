# PWM_breathing_LED
#### Autoři
* Denis Bureš
* Pavel Hroch
* Matyáš Stoupal

### Zadání: 
Vytvořte modul, který plynule mění jas LED diody generováním trojúhelníkového průběhu pro pracovní cyklus PWM, simulující „nádech“ a „výdech“. 

**Rozšíření**: řízení duty cyklu druhé LED pomocí switchů a hexadecimální zobrazení aktuálního nastavení na dva sedmisegmentové displeje. 

### Cíl projektu:
-Jádrem řešení je modul ***breathing_driver***, který na základě devítibitového vstupního logického vektoru generuje výsledný PWM signál, klíčovým prvkem je využití MSB jako přepínače směru jasu, kdy při logické nule jas lineárně narůstá a při logické jedničce začne vnitřní logika zbývajících 8 bitů invertovat, čímž vytváří plynulý efekt zhasínání.

Zatímco v prvním kanálu ***PWM_driver_1*** je tento proces automatizován pomocí ***countr*** a ***clk_en*** pro dosažení cyklického dýchání, druhý kanál ***PWM_driver_2*** využívá stejnou logiku pro statické nastavení jasu, kde je nejvyšší bit pevně uzemněn a zbylých 8 bitů je přímo řízeno mechanickými přepínači.

## Využité součástky
* **Implementace**: Projekt byl vytvářen ve VHDL na desku **Artix-7 FPGA (Nexys A7-50T/100T)**.

| **Komponenty** | **Funkce** | **Popis komponenty** |
| :---: | :---: | :---: |
| **8x Přepínač [J15 - R13]** | Přepínaní jasu | 8 přepínačů nám vytváří 256 možností nastavení jasu |
| **LED [H17]**  | Dýchací LED | LEDka která pomalu zhasíná a rozvící se představující simulaci dýchaní |
| **LED [K15]** | Měnící jas LED | LEDka která mění svůj jas podle nastavení přepínačů |
| **7-seg Displej** | Indikátor | Ukazuje jak velkým jasem momentálně svítí LED [K15] |

## **Bloková schémata:**

### PWM_Breathing_LED: TOP modul 
![](/img/top_PWM_modul_1.png)

**Tabulka pro TOP model:**
| Jméno portu | Směr | Typ |
| :---: | :---: | :--- |
| `clk` | in | `std_logic` |
| `btnu` | in | `std_logic` |
| `seg` | out | `std_logic_vector(6 downto 0)` |
| `an` | out | `std_logic_vector(7 downto 0)` |
| `dp` | out | `std_logic` |
| `led1` | out | `std_logic` |
| `led2` | out | `std_logic` |


### PWM_Driver_1: zajišťuje chod dýchaní 


![](/img/PWM_driver_1_1.png)

**Tabulka pro PWM_driver_1:**
| Jméno portu | Směr | Typ |
| :---: | :---: | :--- |
| `clk` | in | `std_logic` |
| `rst` | in | `std_logic` |
| `led` | out | `std_logic` |

Jako první modul je ***clock enable***, která z hlavního hodinový signálu `clk` generuje úzké pulzy na svém výstupu `ce` s menší frekvencí. Tento výstup `ce` následně ovlivňuje rychlost čítání v modulu ***counter***, který počítá od 0 do maxima (512) a poté zpět od 0. Každou další hodnotu přičíta v momentě kdy `ce` je aktivní. Z výstupu ***counteru*** `cnt`, na kterém je logický vektor aktuálního stavu ***counter***, probíhá řízení posledního bloku ***breathing_driver***. Tento model v sobě uvnitř dělá to, že porovnává jas který má v sobě s `cnt` průběhem. Výsledkem potom je PWM signál, jehož střída se plynule mění v čase, což vytváří vizuální efekt dýchání na LED [H17].     

### PWM_Driver_2: zajišťuje statický jas

![](/img/PWM_driver_2.png)

**Tabulka pro PWM_driver_2:**
| Jméno portu | Směr | Typ |
| :---: | :---: | :--- |
| `clk` | in | `std_logic` |
| `rst` | in | `std_logic` |
| `sw` | in | `std_logic_vector(7 downto 0)` |
| `led` | out | `std_logic` |

**PWM_driver_2** ovládá druhou LED [K15]. Na jeho vstup `cnt` je přiveden signál `s_cnt_expanded(8:0)` ke kterému je ještě přiveden 1 bit `0` jak je vidět na schématu a to z toho důvodu že ***breathing_driver*** který používáme v ***PWM_driver_1*** očekává 9 bitový signál. Jelikož používáme 8 přepínačů, výstup z nich je pouze 8bitový a proto je zde přiveden 9. bit který bude vždy 0 a vytvoří tak 9bitový signál pro ***breathing_driver***. Každý přepínač představuje 1 bit, který je buďto v režimu 0 (off) nebo 1 (on). Tyto bity dohromady budou určovat střídu PWM signálu. Díky tomu budeme ovládat jas LED [K15] a to pomocí toho, že v jedné periodě bude LEDka buďto více svítit nebo bude více zhasnutá, což právě bude mít na starost střída signálu. Tento efekt bude ve výsledku vypadat že LED [K15] bude právě pomocí přepínačů měnit svůj jas.

## **Simulace**

### Breathing_Driver

![](/sim/simulace_breathing.png)

Vidíme jednu celou periodu, kdy LED [H17] se pomalu rozsvící a následně zhasíná
* cnt(7:0): Postupně lineárně narůstá a v každém taktu signálu `clk`, je porovnávána se střídou, která je v ***breathing_driveru*** nastavena pomocí  pulzů z ***counteru***.
* cnt(8): bit, který určuje směr signálu, zda-li se pulz kdy LED[H17] má svítit zvětšuje (stav 0) nebo zmenšuje (stav 1).

### PWM_driver_2

![](/sim/simulace_PWM_driver_2.png)

## **Schéma VHDL**









