# build native or web version of mupen64-plus
# to build web version: 'make web'
# to build native version: 'make native'
# to run web version: 'make run-web'
# to run native version: 'make run-native'
# to specify a rom to load, make sure it's in the ROMS_DIR and load as:
# make ROM="rom.name.n64" run-web

GAMES_DIR ?= ./games
ROM_DIR_NAME ?= roms
ROMS_DIR ?= $(abspath $(ROM_DIR_NAME))
ROM ?= super_mario_64.z64
DEFAULT_ROM := super_mario_64.z64
PLATFORM ?= web
BIN_DIR ?= $(abspath ./bin/$(PLATFORM))
SCRIPTS_DIR := ./scripts

TARGET_ROM = $(BIN_DIR)/roms/$(ROM)
SOURCE_ROM = $(ROMS_DIR)/$(ROM)

POSTFIX ?= -web
SO_EXTENSION ?= .so

UI ?= mupen64plus-ui-console-web-netplay
UI_DIR = $(UI)/projects/unix

CORE ?= mupen64plus-core-web-netplay
CORE_DIR = $(CORE)/projects/unix
CORE_LIB = $(CORE)$(POSTFIX)$(SO_EXTENSION)
CORE_LIB_STATIC = $(CORE_DIR)/libmupen64plus-web.a
CORE_LIB_JS = $(CORE)$(POSTFIX).wasm


LIBSRC_DIR = deps/libsamplerate
AUDIO ?= mupen64plus-audio-sdl
AUDIO_DIR = $(AUDIO)/projects/unix/
AUDIO_LIB = $(AUDIO).so
AUDIO_LIB_JS = $(AUDIO)-web.wasm
AUDIO_LIB_STATIC = $(AUDIO_DIR)/$(AUDIO)-web.a


NATIVE_AUDIO := mupen64plus-audio-sdl
NATIVE_AUDIO_DIR = $(NATIVE_AUDIO)/projects/unix
NATIVE_AUDIO_LIB = $(NATIVE_AUDIO).so

VIDEO ?= mupen64plus-video-glide64mk2
VIDEO_DIR = $(VIDEO)/projects/unix
VIDEO_LIB_JS = $(VIDEO)$(POSTFIX).wasm
VIDEO_LIB = $(VIDEO)$(POSTFIX)$(SO_EXTENSION)
VIDEO_LIB_STATIC = $(VIDEO_DIR)/$(VIDEO)-web.a

RICE = mupen64plus-video-rice-web-netplay
RICE_VIDEO_LIB = $(RICE)-web$(POSTFIX)$(SO_EXTENSION)
RICE_VIDEO_LIB_JS = $(RICE)$(POSTFIX).wasm
RICE_VIDEO_DIR = $(RICE)/projects/unix/
RICE_VIDEO_LIB_STATIC = $(RICE_VIDEO_DIR)/$(RICE)-web.a

INPUT ?= mupen64plus-input-sdl
INPUT_DIR = $(INPUT)/projects/unix
INPUT_LIB = $(INPUT)$(POSTFIX)$(SO_EXTENSION)
INPUT_LIB_JS = $(INPUT)$(POSTFIX).wasm
INPUT_LIB_STATIC = $(INPUT_DIR)/$(INPUT)$(POSTFIX).a

RSP ?= mupen64plus-rsp-hle
RSP_DIR = $(RSP)/projects/unix
RSP_LIB = $(RSP)$(POSTFIX)$(SO_EXTENSION)
RSP_LIB_JS = $(RSP)$(POSTFIX).wasm
RSP_LIB_STATIC = $(RSP_DIR)/$(RSP)$(POSTFIX).a

TARGET ?= mupen64plus
PLUGINS_DIR = $(BIN_DIR)/plugins
OUTPUT_ROMS_DIR = $(BIN_DIR)/$(ROMS_DIR)
TARGET_LIB = $(TARGET)$(POSTFIX)$(SO_EXTENSION)
TARGET_HTML ?= index.html
INDEX_TEMPLATE = $(abspath $(SCRIPTS_DIR)/index.template.html)
PRE_JS = $(abspath $(SCRIPTS_DIR)/prefix.js)
POST_JS = $(abspath $(SCRIPTS_DIR)/postfix.js)
MODULE_JS = module.js


STATIC_PLUGINS = $(CORE_LIB_STATIC) \
		$(AUDIO_LIB_STATIC) \
		$(INPUT_LIB_STATIC) \
		$(RSP_LIB_STATIC) \
		$(RICE_VIDEO_LIB_STATIC)
#		$(VIDEO_LIB_STATIC)


PLUGINS =  $(PLUGINS_DIR)/$(CORE_LIB) \
	$(PLUGINS_DIR)/$(AUDIO_LIB) \
	$(PLUGINS_DIR)/$(INPUT_LIB) \
	$(PLUGINS_DIR)/$(RSP_LIB) \
	$(PLUGINS_DIR)/$(RICE_VIDEO_LIB)
#	$(PLUGINS_DIR)/$(VIDEO_LIB)



INPUT_FILES = \
	$(BIN_DIR)/data/InputAutoCfg.ini \
	$(BIN_DIR)/data/Glide64mk2.ini \
	$(BIN_DIR)/data/RiceVideoLinux.ini \
	$(BIN_DIR)/stats.min.js \
	$(BIN_DIR)/main.js \
	$(BIN_DIR)/data/mupencheat.txt \
	$(INDEX_TEMPLATE) \
	$(BIN_DIR)/$(MODULE_JS) \
	$(BIN_DIR)/data/mupen64plus.cfg \
	$(BIN_DIR)/data/mupen64plus.ini \

define EXPORTED_FUNCTIONS
'_startEmulator', \
'_main', \
'_png_create_write_struct', \
'_png_create_info_struct', \
'_png_destroy_write_struct', \
'_png_set_longjmp_fn', \
'_png_set_write_fn', \
'_png_set_IHDR', \
'_png_set_rows', \
'_png_write_png', \
'_fopen', \
'_fclose', \
'__ZTVN10__cxxabiv117__class_type_infoE', \
'__ZTVNSt3__29basic_iosIcNS_11char_traitsIcEEEE', \
'__ZNSt3__27codecvtIcc11__mbstate_tE2idE', \
'__ZTISt8bad_cast', \
'__ZTISt12length_error', \
'__ZTVSt12length_error', \
'__ZNSt3__25ctypeIcE2idE', \
'__ZTINSt3__213basic_istreamIcNS_11char_traitsIcEEEE', \
'__ZTVN10__cxxabiv120__si_class_type_infoE', \
'__ZTINSt3__215basic_streambufIcNS_11char_traitsIcEEEE', \
'__ZTVSt9exception', \
'__ZTVN10__cxxabiv119__pointer_type_infoE', \
'__ZTISt9exception', \
'__ZNSt3__25ctypeIcE2idE', \
'__ZTVN10__cxxabiv121__vmi_class_type_infoE', \
'_calloc', \
'_fwrite', \
'_png_destroy_read_struct', \
'_fread', \
'_png_sig_cmp', \
'_png_create_read_struct', \
'_png_set_read_fn', \
'_png_set_sig_bytes', \
'_png_read_info', \
'_png_get_IHDR', \
'_png_set_strip_16', \
'_png_set_palette_to_rgb', \
'_png_set_expand_gray_1_2_4_to_8', \
'_png_set_gray_to_rgb', \
'_png_get_valid', \
'_png_set_tRNS_to_alpha', \
'_png_set_filler', \
'_png_set_bgr', \
'_png_get_bKGD', \
'_png_get_tRNS', \
'_png_read_update_info', \
'_png_get_rowbytes', \
'_png_read_image', \
'_png_read_end', \
'_fprintf', \
'_png_malloc', \
'_png_set_PLTE', \
'_png_write_info', \
'_png_write_rows', \
'_png_write_end', \
'___cxa_pure_virtual', \
'__ZNSt8bad_castD1Ev', \
'__ZNSt12length_errorD1Ev', \
'__ZNSt3__213basic_istreamIcNS_11char_traitsIcEEED1Ev', \
'__ZNSt3__213basic_istreamIcNS_11char_traitsIcEEED0Ev', \
'__ZTv0_n12_NSt3__213basic_istreamIcNS_11char_traitsIcEEED1Ev', \
'__ZTv0_n12_NSt3__213basic_istreamIcNS_11char_traitsIcEEED0Ev', \
'__ZNSt3__215basic_streambufIcNS_11char_traitsIcEEE9showmanycEv', \
'__ZNSt3__215basic_streambufIcNS_11char_traitsIcEEE6xsgetnEPcl', \
'__ZNSt3__215basic_streambufIcNS_11char_traitsIcEEE5uflowEv', \
'__ZNSt3__215basic_streambufIcNS_11char_traitsIcEEE6xsputnEPKcl', \
'__Znam', \
'_memset', \
'_SDL_CreateMutex', \
'_memcpy', \
'_vsprintf', \
'_strdup', \
'_stat', \
'_strlen', \
'_strchr', \
'_vsprintf', \
'_vsnprintf', \
'_fseek', \
'_ftell', \
'_isspace', \
'_memmove', \
'_strcasecmp', \
'_sscanf', \
'_strtol', \
'_strtod', \
'_strcpy', \
'_strcat', \
'_fgets', \
'_tolower', \
'_strcmp', \
'_strncmp', \
'_memcmp', \
'_sprintf', \
'_strncpy', \
'_SDL_WasInit', \
'_SDL_InitSubSystem', \
'_SDL_NumJoysticks', \
'_SDL_QuitSubSystem', \
'_strcasestr', \
'_atoi', \
'_SDL_GetError', \
'__ZNSt3__28ios_base4initEPv', \
'__ZNSt3__215basic_streambufIcNS_11char_traitsIcEEEC2Ev', \
'__ZNSt3__26localeC1ERKS0_', \
'__ZNKSt3__26locale9has_facetERNS0_2idE', \
'__ZNSt3__26localeD1Ev', \
'__ZNKSt3__26locale9use_facetERNS0_2idE', \
'__ZNSt3__28ios_base5clearEj', \
'__ZNKSt3__28ios_base6getlocEv', \
'__ZNSt3__213basic_istreamIcNS_11char_traitsIcEEE7getlineEPclc', \
'__Znwm', \
'__ZdlPv', \
'_fseeko'
endef


OPT_LEVEL ?= -O2
DEBUG_LEVEL ?=

#MEMORY = 524288
#MEMORY =  402653184
#MEMORY =  655360000
MEMORY =   1310720000
#MEMORY = 268435456
#MEMORY = 134217728

NATIVE_BIN := bin
NATIVE_PLUGINS := \
		$(NATIVE_BIN)/libmupen64plus.so.2 \
		$(NATIVE_BIN)/mupen64plus-input-sdl.so \
		$(NATIVE_BIN)/mupen64plus-rsp-hle.so \
		$(NATIVE_BIN)/mupen64plus-video-rice-web-netplay.so \
		$(NATIVE_BIN)/mupen64plus-audio-sdl.so \

NATIVE_EXE := $(NATIVE_BIN)/mupen64plus
NATIVE_DEPS := $(NATIVE_PLUGINS) $(NATIVE_EXE)

WEB_DEPS := $(BIN_DIR)/$(TARGET_HTML) $(TARGET_ROM)

ALL_DEPS := $(WEB_DEPS)
ifeq ($(PLATFORM), native)
		ALL_DEPS := $(NATIVE_DEPS)
endif

all: $(ALL_DEPS)

.FORCE:

native: .FORCE
	$(MAKE) PLATFORM=native

web: .FORCE
	$(MAKE) PLATFORM=web

RICE_CFG_DIR := cfg/rice
GLIDE_CFG_DIR := cfg/glide
DATA_DIR := mupen64plus-core-web-data/data

CFG_DIR := $(GLIDE_CFG_DIR)
ifndef rice
	CFG_DIR := $(RICE_CFG_DIR)
endif

CFG_DIR := $(RICE_CFG_DIR)

NATIVE_ARGS ?=

run-native: native
	./$(NATIVE_EXE) $(ROM) \
			$(NATIVE_ARGS) \
			--corelib $(NATIVE_BIN)/libmupen64plus.so.2 \
			--configdir $(CFG_DIR) \
			--datadir $(CFG_DIR) \
			$(ROMS_DIR)/$(ROM)


# use browser=chromium arg (or chrome etc) to test in broser
# e.g. 'make run-web browser=chromium'
BROWSER ?= firefox
ifeq ($(browser), chromium)
		BROWSER := $(shell which chromium-browser)
endif
EMRUN ?= #--emrun

FORWARDSLASH ?= %2F
run-web: web
	emrun $ --browser $(BROWSER) $(BIN_DIR)/index.html --nospeedlimit  $(FORWARDSLASH)$(ROM_DIR_NAME)$(FORWARDSLASH)$(ROM)

run: run-web

clean-native:
	cd mupen64plus-ui-console-web-netplay/projects/unix && $(MAKE) clean
	cd $(CORE_DIR) && $(MAKE) clean
	cd $(INPUT_DIR) && $(MAKE) clean
	cd $(RSP_DIR) && $(MAKE) clean
	cd $(VIDEO_DIR) && $(MAKE) clean
	cd $(RICE_VIDEO_DIR) && $(MAKE) clean
	cd $(AUDIO_DIR) && $(MAKE) clean

clean: clean-web clean-native

rebuild: clean all

$(NATIVE_BIN):
	mkdir $(NATIVE_BIN)

$(NATIVE_EXE): $(NATIVE_BIN) mupen64plus-ui-console-web-netplay/projects/unix/mupen64plus
	cp mupen64plus-ui-console-web-netplay/projects/unix/mupen64plus $@

mupen64plus-ui-console-web-netplay/projects/unix/mupen64plus:
	cd mupen64plus-ui-console-web-netplay/projects/unix && $(MAKE) all

$(NATIVE_BIN)/libmupen64plus.so.2: $(NATIVE_BIN) $(CORE_DIR)/libmupen64plus.so.2.0.0
	cp $(CORE_DIR)/libmupen64plus.so.2.0.0 $@

$(CORE_DIR)/libmupen64plus.so.2.0.0:
	cd $(CORE_DIR) && $(MAKE) all

$(NATIVE_BIN)/mupen64plus-input-sdl.so: $(NATIVE_BIN) $(INPUT_DIR)/mupen64plus-input-sdl.so
	cp $(INPUT_DIR)/mupen64plus-input-sdl.so $@

$(INPUT_DIR)/mupen64plus-input-sdl.so:
	cd $(INPUT_DIR) && $(MAKE) all

$(RSP_DIR)/mupen64plus-rsp-hle.so:
	cd $(RSP_DIR) && $(MAKE) all

$(NATIVE_BIN)/mupen64plus-rsp-hle.so: $(NATIVE_BIN) $(RSP_DIR)/mupen64plus-rsp-hle.so
	cp $(RSP_DIR)/mupen64plus-rsp-hle.so $@

$(VIDEO_DIR)/mupen64plus-video-glide64mk2.so:
	cd $(VIDEO_DIR) && $(MAKE) all

$(NATIVE_BIN)/mupen64plus-video-glide64mk2.so: $(NATIVE_BIN) $(VIDEO_DIR)/mupen64plus-video-glide64mk2.so
	cp $(VIDEO_DIR)/mupen64plus-video-glide64mk2.so $@

$(RICE_VIDEO_DIR)/mupen64plus-video-rice-web-netplay.so:
	cd $(RICE_VIDEO_DIR) && $(MAKE) all

$(NATIVE_BIN)/mupen64plus-video-rice-web-netplay.so: $(NATIVE_BIN) $(RICE_VIDEO_DIR)/mupen64plus-video-rice-web-netplay.so
	cp $(RICE_VIDEO_DIR)/mupen64plus-video-rice-web-netplay.so $@

$(NATIVE_AUDIO_DIR)/mupen64plus-audio-sdl.so:
	cd $(NATIVE_AUDIO_DIR) && $(MAKE) all

$(NATIVE_BIN)/mupen64plus-audio-sdl.so: $(NATIVE_BIN) $(NATIVE_AUDIO_DIR)/mupen64plus-audio-sdl.so
	cp $(NATIVE_AUDIO_DIR)/mupen64plus-audio-sdl.so $@


ifeq ($(config), debug)

OPT_LEVEL = -O0
DEBUG_LEVEL = -g2

else

OPT_LEVEL = -g2 -O3 #-s AGGRESSIVE_VARIABLE_ELIMINATION=1

endif


OPT_FLAGS := $(OPT_LEVEL) \
			$(DEBUG_LEVEL) \
			-s 'EXTRA_EXPORTED_RUNTIME_METHODS=[\"ccall\", \"cwrap\", \"getValue\", \"FS\"]' \
			-DEMSCRIPTEN=1 \
			-DUSE_FRAMESKIPPER=1


STATIC_LIBRARIES =
CORE_LD_LIB = 

ifeq ($(static-plugins), 0)
USE_DYNAMIC_PLUGINS = 1
USE_STATIC_PLUGINS = 0
else
USE_DYNAMIC_PLUGINS = 0
USE_STATIC_PLUGINS = 1

CORE_LD_LIB = ../../../$(CORE_LIB_STATIC)
STATIC_LIBRARIES = ../../../$(AUDIO_LIB_STATIC) \
		../../../$(INPUT_LIB_STATIC) \
		../../../$(RSP_LIB_STATIC) \
		../../../$(CORE_LIB_STATIC) \
		../../../$(RICE_VIDEO_LIB_STATIC) \
		../../../$(LIBSRC_DIR)/build/src/libsamplerate.a

OPT_FLAGS += -DM64P_STATIC_PLUGINS=1
endif


$(PLUGINS_DIR)/%.so : %/projects/unix/%.wasm
	cp "$<" "$@"

$(CORE_LIB_STATIC) : $(CORE_DIR)/$(CORE_LIB_JS)

# libmupen64plus.so.2 deviates from standard naming
$(PLUGINS_DIR)/$(CORE_LIB) : $(CORE_DIR)/$(CORE_LIB_JS)
	mkdir -p $(PLUGINS_DIR)
	cp "$<" "$@"

$(PLUGINS_DIR)/$(AUDIO_LIB) : $(AUDIO_DIR)/$(AUDIO_LIB_JS)
	mkdir -p $(PLUGINS_DIR)
	cp "$<" "$@"

$(AUDIO_LIB_STATIC) : $(AUDIO_DIR)/$(AUDIO_LIB_JS)

$(VIDEO_LIB_STATIC) : $(VIDEO_DIR)/$(VIDEO_LIB_JS)

$(PLUGINS_DIR)/$(VIDEO_LIB) : $(VIDEO_DIR)/$(VIDEO_LIB_JS)
	mkdir -p $(PLUGINS_DIR)
	cp "$<" "$@"

$(PLUGINS_DIR)/$(RICE_VIDEO_LIB) : $(RICE_VIDEO_DIR)/$(RICE_VIDEO_LIB_JS)
	mkdir -p $(PLUGINS_DIR)
	cp -f "$<" "$@"

$(RICE_VIDEO_LIB_STATIC) : $(RICE_VIDEO_DIR)/$(RICE_VIDEO_LIB_JS)

$(PLUGINS_DIR)/$(INPUT_LIB) : $(INPUT_DIR)/$(INPUT_LIB_JS)
	mkdir -p $(PLUGINS_DIR)
	cp "$<" "$@"

$(INPUT_LIB_STATIC) : $(INPUT_DIR)/$(INPUT_LIB_JS);

$(PLUGINS_DIR)/$(RSP_LIB) : $(RSP_DIR)/$(RSP_LIB_JS)
	mkdir -p $(PLUGINS_DIR)
	cp "$<" "$@"

$(RSP_LIB_STATIC) : $(RSP_DIR)/$(RSP_LIB_JS)

$(TARGET_ROM): $(SOURCE_ROM)
	mkdir -p $(@D)
	rm -f $(OUTPUT_ROMS_DIR)/*
	cp "$<" "$@"

$(BIN_DIR) :
	#Creating output directory
	mkdir -p $(BIN_DIR)

rice: $(RICE_VIDEO_DIR)/$(RICE_VIDEO_LIB_JS)

$(RICE_VIDEO_DIR)/$(RICE_VIDEO_LIB_JS):
	cd $(RICE_VIDEO_DIR) && \
			emmake $(MAKE) \
			CROSS_COMPILE="" \
			POSTFIX=-web\
			UNAME=Linux \
			USE_FRAMESKIPPER=1 \
			EMSCRIPTEN=1 \
			M64P_STATIC_PLUGINS=$(USE_STATIC_PLUGINS) \
			SO_EXTENSION="wasm" \
			USE_GLES=1 \
			NO_ASM=1 \
			ZLIB_CFLAGS="-s USE_ZLIB=1" \
			PKG_CONFIG="" \
			LIBPNG_CFLAGS="-s USE_LIBPNG=1" \
			SDL_CFLAGS="-s USE_SDL=2" \
			FREETYPE2_CFLAGS="-s USE_FREETYPE=1" \
			GL_CFLAGS="" \
			GLU_CFLAGS="" \
			V=1 \
			LOADLIBES="" \
			LDLIBS="$(CORE_LD_LIB)" \
			OPTFLAGS="$(OPT_FLAGS) -s SIDE_MODULE=$(USE_DYNAMIC_PLUGINS) -s FULL_ES2=1 -DNO_FILTER_THREAD=1"\
			all

# input files helpers
$(BIN_DIR)/data/InputAutoCfg.ini: $(CFG_DIR)/InputAutoCfg.ini
	mkdir -p $(@D)
	cp $< $@

$(BIN_DIR)/data/Glide64mk2.ini: $(GLIDE_CFG_DIR)/Glide64mk2.ini
	mkdir -p $(@D)
	cp $< $@

$(BIN_DIR)/data/RiceVideoLinux.ini: $(RICE_CFG_DIR)/RiceVideoLinux.ini
	mkdir -p $(@D)
	cp $< $@

$(BIN_DIR)/$(MODULE_JS): $(SCRIPTS_DIR)/$(MODULE_JS)
	mkdir -p $(@D)
	cp $< $@

$(BIN_DIR)/stats.min.js: $(SCRIPTS_DIR)/stats.min.js
	cp $< $@

$(BIN_DIR)/main.js: $(SCRIPTS_DIR)/main.js
	cp $< $@

$(BIN_DIR)/data/mupen64plus.cfg: $(CFG_DIR)/mupen64plus-web.cfg
	cp $< $@

$(BIN_DIR)/data/mupen64plus.ini: $(CFG_DIR)/mupen64plus.ini
	cp $< $@

$(BIN_DIR)/data/mupencheat.txt: $(CFG_DIR)/mupencheat.txt
	cp $< $@

$(BIN_DIR)/$(TARGET_HTML): $(INDEX_TEMPLATE) $(PLUGINS) $(STATIC_PLUGINS) $(INPUT_FILES)
	@mkdir -p $(BIN_DIR)
	rm -f $@
	# building UI (program entry point)
	cd $(UI_DIR) && \
		EMCC_FORCE_STDLIBS="libc++,libc" emmake make \
			POSTFIX=-web \
			TARGET=$(BIN_DIR)/$(TARGET_HTML) \
			UNAME=Linux \
			EMSCRIPTEN=1 \
			M64P_STATIC_PLUGINS=$(USE_STATIC_PLUGINS) \
			EXEEXT=".html" \
			USE_GLES=1 \
			ZLIB_CFLAGS="-s USE_ZLIB=1" \
			PKG_CONFIG="" \
			LIBPNG_CFLAGS="-s USE_LIBPNG=1" \
			SDL_CFLAGS="-s USE_SDL=2" \
			FREETYPE2_CFLAGS="-s USE_FREETYPE=1" \
			GL_CFLAGS="" \
			GLU_CFLAGS="" \
			V=1 \
			LDLIBS="$(STATIC_LIBRARIES)" \
			OPTFLAGS="$(OPT_FLAGS) -v \
			-s MAIN_MODULE=$(USE_DYNAMIC_PLUGINS) \
			-s EXPORT_ALL=1 \
			--use-preload-plugins -lidbfs.js \
			-s EXPORT_ALL=1 --preload-file $(BIN_DIR)/data@data \
			--shell-file $(INDEX_TEMPLATE) \
			--js-library ../../../mupen64plus-audio-web/src/jslib/audiolib.js \
			--js-library ../../../mupen64plus-core-web-netplay/src/jslib/corelib.js \
			-s INITIAL_MEMORY=$(MEMORY) \
			-s \"EXPORTED_FUNCTIONS=[$(EXPORTED_FUNCTIONS)]\" \
			-s DEMANGLE_SUPPORT=1 -s MODULARIZE=1 -s EXPORT_NAME=\"createModule\" \
			-s ENVIRONMENT='web' -s EXPORT_ES6=0 \
			-s NO_EXIT_RUNTIME=1 -s USE_ZLIB=1 \
			-s USE_SDL=2 -s USE_LIBPNG=1 -s FULL_ES2=1 \
			-s ASYNCIFY=1 -s 'ASYNCIFY_IMPORTS=[\"waitForReliableMessage\"]' \
			-s USE_BOOST_HEADERS=1 \
			-DEMSCRIPTEN=1 --pre-js $(PRE_JS) --post-js $(POST_JS) \
			-DINPUT_ROM=$(DEFAULT_ROM) $(EMRUN)" \
			all

core: $(CORE_DIR)/$(CORE_LIB)

$(CORE_DIR)/$(CORE_LIB_JS) :
	cd $(CORE_DIR) && \
	emmake make \
		POSTFIX=-web \
		UNAME=Linux \
		EMSCRIPTEN=1 \
		M64P_STATIC_PLUGINS=$(USE_STATIC_PLUGINS) \
		TARGET="$(CORE_LIB_JS)" \
		SONAME="" \
		SO_EXTENSION="wasm" \
		USE_GLES=1 \
		NO_ASM=1 \
		ZLIB_CFLAGS="-s USE_ZLIB=1" \
		PKG_CONFIG="" \
		LIBPNG_CFLAGS="-s USE_LIBPNG=1" \
		SDL_CFLAGS="-s USE_SDL=2" \
		FREETYPE2_CFLAGS="-s USE_FREETYPE=1" \
		GL_CFLAGS="" \
		GLU_CFLAGS="" \
		NETPLAY=1 \
		V=1 \
		OPTFLAGS="$(OPT_FLAGS) -s SIDE_MODULE=$(USE_DYNAMIC_PLUGINS) -s EXPORT_ALL=1 -s INITIAL_MEMORY=$(MEMORY) -DONSCREEN_FPS=1 -s USE_SDL=2 -s ASYNCIFY=1 -I ../../src/api --js-library ../../../mupen64plus-core-web-netplay/src/jslib/corelib.js" \
		all


libsrc:
	cd $(LIBSRC_DIR) && \
	mkdir -p build && \
	cd build && \
	emcmake cmake .. && \
	emmake make

audio: $(AUDIO_DIR)/$(AUDIO_LIB)

$(AUDIO_DIR)/$(AUDIO_LIB_JS) : libsrc
	cd $(AUDIO_DIR) && \
		emmake make \
		POSTFIX=-web \
		UNAME="Linux" \
		EMSCRIPTEN=1 \
		M64P_STATIC_PLUGINS=$(USE_STATIC_PLUGINS) \
		NO_OSS=1 \
		SO_EXTENSION="wasm" \
		USE_GLES=1 \
		ZLIB_CFLAGS="-s USE_ZLIB=1" \
		PKG_CONFIG="" \
		LIBPNG_CFLAGS="-s USE_LIBPNG=1" \
		SDL_CFLAGS="-s USE_SDL=2" \
		FREETYPE2_CFLAGS="-s USE_FREETYPE=1" \
		GL_CFLAGS="" \
		GLU_CFLAGS="" \
		V=1 \
		SRC_LDLIBS="../../../$(LIBSRC_DIR)/build/src/libsamplerate.a" \
		OPTFLAGS="$(OPT_FLAGS) -s SIDE_MODULE=$(USE_DYNAMIC_PLUGINS) -fPIC -DNO_FILTER_THREAD=1 -I../../../$(LIBSRC_DIR)/include --js-library ../../src/jslib"\
		all

glide: $(VIDEO_DIR)/$(VIDEO_LIB)

$(VIDEO_DIR)/$(VIDEO_LIB_JS):
	cd $(VIDEO_DIR) && \
	emmake make \
		POSTFIX=-web \
		USE_FRAMESKIPPER=1 \
		EMSCRIPTEN=1 \
		M64P_STATIC_PLUGINS=$(USE_STATIC_PLUGINS) \
		SO_EXTENSION="wasm" \
		USE_GLES=1 \
		NO_ASM=1 \
		ZLIB_CFLAGS="-s USE_ZLIB=1" \
		PKG_CONFIG="" \
		LIBPNG_CFLAGS="-s USE_LIBPNG=1" \
		SDL_CFLAGS="-s USE_SDL=2" \
		FREETYPE2_CFLAGS="-s USE_FREETYPE=1" \
		GL_CFLAGS="" \
		GLU_CFLAGS="" \
		V=1 \
		LOADLIBES="" \
		LDLIBS="$(CORE_LD_LIB)" \
		OPTFLAGS="$(OPT_FLAGS) -s SIDE_MODULE=$(USE_DYNAMIC_PLUGINS) -s FULL_ES2=1 -DNO_FILTER_THREAD=1 -s USE_BOOST_HEADERS=1" \
		all

input: $(INPUT_DIR)/$(INPUT_LIB)


# ../../../mupen64plus-core-web-netplay/projects/unix/libmupen64plus-web.a

$(INPUT_DIR)/$(INPUT_LIB_JS): $(CORE_LIB_STATIC)
	cd $(INPUT_DIR) && \
	emmake make \
		POSTFIX=-web \
		UNAME="Linux" \
		EMSCRIPTEN=1 \
		M64P_STATIC_PLUGINS=$(USE_STATIC_PLUGINS) \
		SO_EXTENSION="wasm" \
		USE_GLES=1 NO_ASM=1 \
		ZLIB_CFLAGS="-s USE_ZLIB=1" \
		PKG_CONFIG="" \
		LIBPNG_CFLAGS="-s USE_LIBPNG=1" \
		SDL_CFLAGS="-s USE_SDL=2" \
		FREETYPE2_CFLAGS="-s USE_FREETYPE=1" \
		GL_CFLAGS="" \
		GLU_CFLAGS="" \
		V=1 \
		LDLIBS="" \
		OPTFLAGS="$(OPT_FLAGS) -s SIDE_MODULE=$(USE_DYNAMIC_PLUGINS)"\
		all

rsp: $(RSP_DIR)/$(RSP_LIB)

$(RSP_DIR)/$(RSP_LIB_JS) :
	cd $(RSP_DIR)&& \
	emmake make \
		POSTFIX=-web \
		UNAME=Linux \
		EMSCRIPTEN=1 \
		M64P_STATIC_PLUGINS=$(USE_STATIC_PLUGINS) \
		SO_EXTENSION="wasm" \
		USE_GLES=1 NO_ASM=1 NO_OSS=1 \
		ZLIB_CFLAGS="-s USE_ZLIB=1" \
		PKG_CONFIG="" \
		LIBPNG_CFLAGS="-s USE_LIBPNG=1" \
		SDL_CFLAGS="-s USE_SDL=2" \
		FREETYPE2_CFLAGS="-s USE_FREETYPE=1" \
		GL_CFLAGS="" \
		GLU_CFLAGS="" \
		V=1 \
		OPTFLAGS="$(OPT_FLAGS) -s SIDE_MODULE=$(USE_DYNAMIC_PLUGINS) -DVIDEO_HLE_ALLOWED=1" \
		all

clean-ui:
	rm -rf $(UI_DIR)/_obj$(POSTFIX)
	rm -f $(BIN_DIR)/index.*
	rm -f $(BIN_DIR)/main.js

clean-web:
	rm -fr $(BIN_DIR)
	rm -f $(CORE_DIR)/$(CORE_LIB)
	rm -f $(CORE_DIR)/$(CORE_LIB_JS)
	rm -fr $(CORE_DIR)/_obj$(POSTFIX)
	rm -f $(AUDIO_DIR)/$(AUDIO_LIB)
	rm -f $(AUDIO_DIR)/$(AUDIO_LIB_JS)
	rm -fr $(AUDIO_DIR)/_obj$(POSTFIX)
	rm -f $(AUDIO_LIB_STATIC)
	rm -f $(VIDEO_DIR)/$(VIDEO_LIB)
	rm -f $(VIDEO_DIR)/$(VIDEO_LIB_JS)
	rm -fr $(VIDEO_DIR)/_obj$(POSTFIX)
	rm -f $(INPUT_DIR)/$(INPUT_LIB)
	rm -f $(INPUT_DIR)/$(INPUT_LIB_JS)
	rm -fr $(INPUT_DIR)/_obj$(POSTFIX)
	rm -f $(INPUT_LIB_STATIC)
	rm -f $(RSP_DIR)/$(RSP_LIB)
	rm -f $(RSP_DIR)/$(RSP_LIB_JS)
	rm -f $(RSP_LIB_STATIC)
	rm -fr $(RSP_DIR)/_obj$(POSTFIX)
	rm -f $(RICE_VIDEO_DIR)/$(RICE_VIDEO_LIB)
	rm -f $(RICE_VIDEO_DIR)/$(RICE_VIDEO_LIB_JS)
	rm -fr $(RICE_VIDEO_DIR)/_obj$(POSTFIX)
	rm -f $(RICE_VIDEO_LIB_STATIC)
	rm -fr $(UI_DIR)/_obj$(POSTFIX)

clean-video:
	rm -fr $(BIN_DIR)
	rm -f $(VIDEO_DIR)/$(VIDEO_LIB)
	rm -f $(VIDEO_DIR)/$(VIDEO_LIB_JS)
	rm -fr $(VIDEO_DIR)/_obj$(POSTFIX)
	rm -f $(RICE_VIDEO_DIR)/$(RICE_VIDEO_LIB)
	rm -f $(RICE_VIDEO_DIR)/$(RICE_VIDEO_LIB_JS)
	rm -fr $(RICE_VIDEO_DIR)/_obj$(POSTFIX)
	rm -f $(RICE_VIDEO_LIB_STATIC)
	rm -fr $(UI_DIR)/_obj$(POSTFIX)
