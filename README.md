# Incidencias de trafico en Euskadi

### Introduction ###

En este proyecto haremos uso del datashet publico de incidencias de trafico en euskadi que nos proporciona [datos.gob.es](https://datos.gob.es/es/catalogo/a16003011-incidencias-del-trafico-en-tiempo-real-en-euskadi).

Concretamente utilizaremos "Incidencias del tráfico geolocalizadas" para luego poder utilizar los datos de geolicalizacion en un mapa de coordenadas y ver en que zonas se producen más incidencias de trafico, cuales son las carreteras con mas incidencias, los motivos y causas, etc...

### Requirements ###
- Elasticsearch > v6.0
- Logstash > v6.0
- Kibana > v6.0
- Licencia "Basic" en elastic si quieres hacer zoom en el mapa de más de x10

### Running ###

#### Download datashet.
Lanzar el comando **"incidencias.sh"** el cual descarga el datashet.

#### Import index template.

PUT _template/incidencias-trafico
  {
    "order" : 0,
    "index_patterns" : [
      "incidencias-trafico*"
    ],
    "settings" : {
      "index" : {
        "number_of_shards" : "1"
      }
    },
    "mappings" : {
      "properties" : {
        "location" : {
          "type" : "geo_point"
        }
      }
    },
    "aliases" : { }
  }

o

curl -XPUT "http://localhost:9200/_template/incidencias-trafico" -H 'Content-Type: application/json' -d'{    "order" : 0,    "index_patterns" : [      "incidencias-trafico*"    ],    "settings" : {      "index" : {        "number_of_shards" : "1"      }    },    "mappings" : {      "properties" : {        "location" : {          "type" : "geo_point"        }      }    },    "aliases" : { }  }'

#### Running logstash
/usr/share/logstash/bin/logstash -f logstash.conf


### Import Objects ###

Ahora vamos a importar los objetos (busquedas,visualizaciones,dash, etc..) en kibana, para ello:

Management > Kibana > Index Patterns, añade el patron incidencias-trafico-euskadi-* y el campo de tiempo @timestamp .
Management > Kibana > Saved Objects, importa kibana.ndjson .

Te pedira sobreescribir el patron y alguna cosa más, dale a que **si**.

### Let´s go! ###
Asi es como deberia de quedarte, ahora a jugar con los datos!

![imagen_resultado](https://github.com/igorneos/incidencias-trafico-euskadi/blob/master/incidencias1.png)

![imagen_resultado](https://github.com/igorneos/incidencias-trafico-euskadi/blob/master/incidencias2.png)
