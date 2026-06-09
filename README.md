# Willkommen zu unserem Packer Workshop

Der Workshop dient dazu, die Grundlagen von HashiCorp Packer zu erlernen.

Der Workshop findet an drei aneinanderfolgenden Tagen a 60 Minuten statt. Jeder Tag besteht aus einem Theorieteil und einem Lab. Der Theorieteil sorgt dafür, dass wir eine theoretische Basis haben und darauf aufbauen können. Die Labs verfestigen die theoretischen Aspekte. In den Labs werden wir nicht nur mit Demonstrationen arbeiten, sondern wir werden aktiv Packer verwenden, inklusive der HashiCorp Configuration Language (HCL).

HCL ist ein großer Bestandteil im Geschäft der Cloud. HCL wird nicht nur in Packer verwendet, sondern im Großteil des Ökosystems von HashiCorp, inklusive Terraform. Wer HCL schreiben und lesen kann, hat in der heutigen Zeit der Cloud enorme Vorteile.

## Vorraussetzungen

Fur die Labs des Workshops werden einige Vorraussetzungen benotigt. Um einen schnellen Einstieg zu gewahrleisten, bitte ich euch, diese Vorraussetzungen schon vor Beginn des Workshops zu erfullen. Falls es Probleme geben sollte, konnt ihr euch gerne an mich wenden.

### Benotigte Software

- Linux Betriebssystem
- Packer [installieren](https://developer.hashicorp.com/packer/install)
- VirtualBox [installieren](https://www.virtualbox.org/wiki/Linux_Downloads)
- Git [installieren](https://git-scm.com/install/linux)
- VS Code [installieren](https://code.visualstudio.com/download) (oder praferierten Code Editor)

### Mindestanfoderungen an die Hardware

- 4 CPU-Kerne
- 8 GB RAM
- Mindestens 80 GB freien Festplattenspeicher

### Ausserdem

- Linux-Grundkentnisse
- Klonen des [GitHub Projektes](https://github.com/NemanjaTomic57/packer-workshop)

```bash
git clone https://github.com/NemanjaTomic57/packer-workshop.git
```

## Agenda

### Tag 1

1. Einführung in virtuelle Maschinen
2. Virtuelle Maschinen vs. Golden Images
3. Infrastructure as Code
4. HashiCorp Packer Installation durchführen

Lab: Eine virtuelle Maschine mit Packer installieren und anschließend klonen

### Tag 2

1. HashiCorp Configuration Language
2. Packer Dateien und Verzeichnisse
3. Struktur eines Packer Projektes (source, build)
4. Konfiguration von cloud-init
5. Packer boot_command und http_directory

Lab: Vollautomatisierte Installation einer VM auf Ubuntu

### Tag 3

1. Wie wird Packer in Projekten angewendet?
2. Fur welche Umgebungen kann Packer genutzt werden?
3. Shell Provisionierung in Packer
4. Packer Post-Prozessoren

Lab: Systemupdate & Installation der GuestTools

Demo: Virtuelle Maschinen mit HashiCorp Vagrant erstellen
