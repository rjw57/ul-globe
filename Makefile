OUTPUT_DIR:=app
GLOBE_TILE_DIR:=$(OUTPUT_DIR)/tiles/globe
SOURCE_DIR:=src
GLOBE_RASTER:=rasters/globe.tiff
SOURCE_FILES:=$(wildcard $(SOURCE_DIR)/*.html) \
	$(wildcard $(SOURCE_DIR)/*.js) $(wildcard $(SOURCE_DIR)/*.css) \
	$(wildcard $(SOURCE_DIR)/*.jpg)
COASTLINES_GEOJSON:=$(OUTPUT_DIR)/coastline.geojson
COASTLINES:=vector/ne_110m_coastline/ne_110m_coastline.shp

PYTHON?=$(shell which python)
OGR2OGR?=$(shell which ogr2ogr)
GDAL2TILE:=gdal2tile/gdal2tilesp.py

all: copy-app globe-tiles $(COASTLINES_GEOJSON)

globe-tiles:
	mkdir -p "$(GLOBE_TILE_DIR)"
	"$(PYTHON)" "$(GDAL2TILE)" -f JPEG -w none -e \
		"$(GLOBE_RASTER)" "$(GLOBE_TILE_DIR)"

$(COASTLINES_GEOJSON): $(COASTLINES)
	$(OGR2OGR) -f GeoJSON -wrapdateline \
		"$(COASTLINES_GEOJSON)" "$(COASTLINES)"

copy-app:
	mkdir -p "$(OUTPUT_DIR)"
	cp $(SOURCE_FILES) "$(OUTPUT_DIR)"
	cp "rasters/ul-globe.tiff" "$(OUTPUT_DIR)"

clean:
	rm -r "$(OUTPUT_DIR)"

.PHONY: all globe-tiles copy-app clean
