# PWM_breathing_LED
Blokové schéma:
![Bloková schémata](PWM_driver_2.png)

Zadání
Vytvořit modul, který plynule mění jas LED diody generováním trojúhelníkového průběhu pro pracovní cyklus PWM, simulující „nádech“ a „výdech“.

Pulse Width Modulation (PWM)
Tento projekt využívá techniku PWM (Pulzně šířková modulace) pro efektivní řízení výkonu dodávaného do periferií (např. jas LED, rychlost motoru). Na rozdíl od lineární regulace napětí, která by byla energeticky ztrátová, PWM funguje na principu rychlého spínání a vypínání digitálního signálu.

Jak to funguje?
PWM simuluje analogové napětí pomocí digitálního výstupu, který osciluje mezi stavy HIGH (např. 5V) a LOW (0V). Klíčovým parametrem je poměr času, po který je signál aktivní, k celkové periodě jednoho cyklu.


