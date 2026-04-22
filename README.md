# PWM_breathing_LED
Zadání: Řízení dýchání LED pomocí pulsní šířkové modulace v trojúhelníkovém signálu, k projektu dále patří rozšíření, které obsahuje: řízení duty cyklu druhé LED pomocí switchů a hexadecimální zobrazení aktuálního nastavení na dva sedmisegmentové displeje. 


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

![](PWM_driver_1.png)
**Tabulka pro driver1:**
|  IN      |  OUT     |
|    ---   |    ---   |
| CLK      | LED1     |
| RST      |    X     |




![](PWM_driver_2.png)
**Tabulka pro driver2:**
|  IN      |  OUT     |
|    ---   |    ---   |
| CLK      |          |
| RST      |    LED2  |
| CNT      |    X     |


**Popis komponent:**

Driver_1: zajišťuje chod dýchaní LED1 

Driver_1: zajišťuje statický jas LED2






