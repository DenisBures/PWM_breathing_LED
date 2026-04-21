# PWM_breathing_LED
Blokové schéma:
![Bloková schémata](<img width="908" height="441" alt="PWM_driver_2" src="https://github.com/user-attachments/assets/f89dc4c0-77ba-4d57-82ca-f9f3cbc99c1b" />
)

Zadání
Vytvořit modul, který plynule mění jas LED diody generováním trojúhelníkového průběhu pro pracovní cyklus PWM, simulující „nádech“ a „výdech“.

Pulse Width Modulation (PWM)
Tento projekt využívá techniku PWM (Pulzně šířková modulace) pro efektivní řízení výkonu dodávaného do periferií (např. jas LED, rychlost motoru). Na rozdíl od lineární regulace napětí, která by byla energeticky ztrátová, PWM funguje na principu rychlého spínání a vypínání digitálního signálu.

Jak to funguje?
PWM simuluje analogové napětí pomocí digitálního výstupu, který osciluje mezi stavy HIGH (např. 5V) a LOW (0V). Klíčovým parametrem je poměr času, po který je signál aktivní, k celkové periodě jednoho cyklu.


