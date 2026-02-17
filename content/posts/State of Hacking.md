---
title: State of Hacking
date: 2025-05-23
categories: ["Hacking"]
tags:
  - "#Hacking"
draft: false
---
# Einleitung
Heute reicht es schon lange nicht mehr nur die OWASP Top 10 Liste im Auge zu behalten. Auch die Top 10 Listen für Mobile Security und LLMs wollen beachtet werden.
Im folgenden werden wir eintauchen in die aktuellen Cyberangriffs Trends.
# Datengrundlage
Daten von der Platform HackerOne (ca. 500,000 Schwachstellenreports) sowie Umfragen in der HackerOne Community.

# KI
Diese Risiken unternehmen im Kontext mit KI.
!![Image Description](/images/Pasted%20image%2020250523103109.webp)
## KI Safty vs. KI Security
Während KI Safty sich darauf bezieht, dass ein KI System keine gefährlichen Inhalte, wie eine Anleitung zum Bau einer Bombe, ausgibt, fokussiert sich die KI Security darauf den Missbrauch der KI zu verhindern.
## Wie kann mir KI als Pentester helfen?
KI unterstütz bei der Erstellung von Pentestberichten, und fasst Dokumentationen von eingesetzten Technologien zusammen. Außerdem können passgenauere Wortlisten generiert werden. 
# Top 10 Sicherheitslücken
## Insecure Direct Object Reference
## Cross-site scripting
Häufig in veralteten Anwendung der Regierung.
### Empfehlungen
Alle Benutzereingaben sollten als bösartig bewertet werden. Ferner sollte eine Liste erstellt werden, die die erwarteten Eingabewerte enthält.
Die Ausgabe sollte encodiert werden. Darüber hinaus sollte eine CSP implementiert werden, die die Quellen von ausführbaren Scripten minimiert.
## Unzureichende Authentifizierung
### Empfehlungen
Es sollten robuste und sichere Authentifizierung Methoden implementiert werden. Dazu zählt, starke Passwortrichtlinien, Multi-Faktor-Authentifizierung, das sichere speichern von Passwörtern sowie ein Account Lockout Mechanismus.
Session und Auth-Token sollten zufällig generiert , einzigartig und und unvorhersagbar sein. Ferner sollten die Token sicher serverseitig gespeichert werden. Eine angemessene Sessionlaufzeit und ein Logout-Mechanismus sollten implementiert sein. Der Einsatz von persistenten Token sollte vermieden werden.
Die Ausgabe von zu viel Informationen über APIs, Fehlermeldungen oder Logs sollten unterbunden werden, damit Angreifer keine Informationen über die Anwendung erhalten.
## Informationsausgabe
Sensible Daten sollten sowohl beim Transport als auch auf dem Server verschlüsselt sein. Die Ausgabe von zu viel Informationen über APIs, Fehlermeldungen oder Logs sollten unterbunden werden, damit Angreifer keine Informationen über die Anwendung erhalten. Das Prinzip von "Least Privilege" sollte verfolgt werden. Benutzer und Prozesse sollten nur die Rechte erhalten, die sie benötigen, um die für sie vorgesehenen Aktivitäten in der Anwendung auszuführen.
## SQL-Injections
## Fehlkonfiguration
## Rechteausweitung
## Improper Access Control
## Business Logic Errors
### Empfehlungen
Use test-driven development and extensive unit and integration testing to simulate various scenarios and edge cases.
Enforce multi-signature requirements for critical operations to reduce the risk of flawed transactions.
## Open Redirect
### Empfehlungen
Implement input validation and sanitization for all user inputs and avoid using user-controllable data in URLs.
Provide clear warning for all redirects, notify users they are leaving the site, display the destination, and require a conformation click.
Sanitize input by creating a list of trusted URLs (lists of hosts or a regex). Implement the use of an allow list rather than a deny list.