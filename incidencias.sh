#!/bin/bash
URL="https://www.trafikoa.eus/servicios/IncidenciasTDT/IncidenciasTrafikoTDTGeo"
TMP="/tmp/incidencias/IncidenciasTDT.xml"
mkdir /tmp/incidencias
wget $URL -O $TMP
echo -e "\n" >> $TMP
