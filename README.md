# PWM_breathing_LED
Zadání: Řízení dýchání LED pomocí pulsní šířkové modulace v trojúhelníkovém signálu, k projektu dále patří rozšíření, které obsahuje: řízení duty cyklu druhé LED pomocí switchů a hexadecimální zobrazení aktuálního nastavení na dva sedmisegmentové displeje. 

-Jádrem řešení je modul breathing_driver, který na základě devítibitového vstupního vektoru generuje výsledný PWM signál, klíčovým prvkem je využití nejvyššího (9.) bitu jako přepínače směru jasu, kdy při logické nule jas lineárně narůstá a při logické jedničce začne vnitřní logika zbývajících 8 bitů invertovat, čímž vytváří plynulý efekt zhasínání.

Zatímco v prvním kanálu PWM_driver_1 je tento proces automatizován pomocí čítače a děličky hodin pro dosažení cyklického dýchání, druhý kanál PWM_driver_2 využívá stejnou logiku pro statické nastavení jasu, kde je nejvyšší bit pevně uzemněn a zbylých 8 bitů je přímo řízeno mechanickými přepínači.



**Bloková schémata:**
![](PWM_Breathing_LED_top.png)

**Tabulka pro top:**
|  IN      |  OUT     |
|    ---   |    ---   |
| CLK      | Seg0(6:0)|
| RST      |  dp      |
| SW(7:0)  | an(1:0)  |
|    X     | Seg1(6:0)|
|    X     | LED1     |
|    X     | LED2     |

Driver_1: zajišťuje chod dýchaní LED1


![](PWM_driver_1.png)
**Tabulka pro driver1:**
|  IN      |  OUT     |
|    ---   |    ---   |
| CLK      | LED1     |
| RST      |    X     |


Driver_2: zajišťuje statický jas LED2

![](PWM_driver_2.png)
**Tabulka pro driver2:**
|  IN      |  OUT     |
|    ---   |    ---   |
| CLK      |   LED2   |
| RST      |    X     |
| CNT      |    X     |









