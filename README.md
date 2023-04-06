# Agentie de Turism
Acest proiect implementează un sistem de baze de date relaționale, conceput pentru a stoca și gestiona o varietate de informații legate de aranjamente de călătorie și rezervări. Aceste colecții oferă acces rapid și eficient la date și acceptă interogări și tranzacții complexe datorită unei diagrame Entity-Relationship bine structurată și normalizării 3NF.

Descrierea sistemului informatic "Agenție de turism":

1. O agenție de turism are mai multe filiale. Fiecare filială are un contract încheiat cu agenția principală.

2. Fiecare filială a unei agenții de turism are angajați care au un contract de muncă încheiat și care pot face contracte clienților filialei.

3. Turiștii vor fi identificați în baza de date a agenției de turism prin CNP, nume, prenume, data nașterii, numărul de telefon și cod grup.

4. Agenția de turism prestează servicii în baza unor contracte încheiate cu clienții săi, în cadrul cărora vor fi precizate codul grupului de clienți (dacă un  client călătorește singur atunci codul grupului va fi unic), id-ul contractului, data contractării, avansul acordat, data de scadență  a plății integrale a serviciului prestat de agenție, id-ul angajatului care a încheiat contractul și id-ul ofertei prezentate de agenție.

5. Oferta agenției de turism poate furniza clienților mai multe categorii de servicii sub formă de cazare și transport.

6. Fiecare tip de serviciu va avea atât un id de identificare, cât și un id al contractului întemeiat cu filiala agenției de turism și un id al ofertei prezentate clientului.

7. Copiii cu vârsta cuprinsă între 3 și 6 ani vor beneficia de un tarif promoțional, calculat în urma aplicării unui discount de 90\%, în timp ce persoanele pensionare (vârsta mai mare sau egală cu 65 de ani) vor avea parte de un discount de 60\%.

8. Un contract poate avea unul sau mai mulți beneficiari. De exemplu, o familie care dorește să plece în vacanță poate încheia un singur contract pentru toți membrii, fiecare membru având același cod de grup. 

9. Un client poate încheia unul sau mai multe contracte (același client poate pleca de mai multe ori în vacanță prin intermediul acestei agenții de turism) și de fiecare dată va avea alt cod de grup atribuit.

10. Pentru fiecare tip de serviciu selectat de client, va fi încheiat un contract cu filiala agenției de turism.
