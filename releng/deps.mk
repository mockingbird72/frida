frida_deps_version = 20210607
frida_bootstrap_version = 20210606


frida_base_url = https://github.com/frida
gnu_mirror = saimei.ftp.acc.umu.se/mirror/gnu.org/gnu


include releng/system.mk

ifdef FRIDA_HOST
host_os := $(shell echo $(FRIDA_HOST) | cut -f1 -d"-")
host_arch := $(shell echo $(FRIDA_HOST) | cut -f2 -d"-")
else
host_os := $(build_os)
host_arch := $(build_arch)
endif
host_os_arch := $(host_os)-$(host_arch)


libiconv_version = 1.16
libiconv_url = https://$(gnu_mirror)/libiconv/libiconv-$(libiconv_version).tar.gz
libiconv_hash = e6a1b1b589654277ee790cce3734f07876ac4ccfaecbee8afa0b649cf529cc04
libiconv_recipe = autotools
libiconv_patches = \
	$(NULL)
libiconv_options = \
	$(NULL)
libiconv_deps = \
	$(NULL)
libiconv_deps_for_build = \
	$(NULL)

m4_version = 1.4.18
m4_url = https://$(gnu_mirror)/m4/m4-$(m4_version).tar.gz
m4_hash = ab2633921a5cd38e48797bf5521ad259bdc4b979078034a3b790d7fec5493fab
m4_recipe = autotools
m4_patches = \
	m4-vasnprintf-apple-fix.patch \
	m4-ftbfs-fix.patch \
	$(NULL)
m4_options = \
	$(NULL)
m4_deps = \
	$(NULL)
m4_deps_for_build = \
	$(NULL)

autoconf_version = 2.69
autoconf_url = https://$(gnu_mirror)/autoconf/autoconf-$(autoconf_version).tar.gz
autoconf_hash = 954bd69b391edc12d6a4a51a2dd1476543da5c6bbf05a95b59dc0dd6fd4c2969
autoconf_recipe = autotools
autoconf_patches = \
	autoconf-uclibc.patch \
	autoconf-doc-fix-texinfo-macro-usage.patch \
	$(NULL)
autoconf_options = \
	$(NULL)
autoconf_deps = \
	m4 \
	$(NULL)
autoconf_deps_for_build = \
	$(NULL)

automake_version = 1.16.2
automake_url = https://$(gnu_mirror)/automake/automake-$(automake_version).tar.gz
automake_hash = b2f361094b410b4acbf4efba7337bdb786335ca09eb2518635a09fb7319ca5c1
automake_recipe = autotools
automake_patches = \
	$(NULL)
automake_options = \
	$(NULL)
automake_deps = \
	autoconf \
	$(NULL)
automake_deps_for_build = \
	$(NULL)
automake_api_version = 1.16

libtool_version = 2.4.6
libtool_url = https://$(gnu_mirror)/libtool/libtool-$(libtool_version).tar.gz
libtool_hash = e3bd4d5d3d025a36c21dd6af7ea818a2afcd4dfc1ea5a17b39d7854bcd0c06e3
libtool_recipe = custom
libtool_patches = \
	libtool-fixes.patch \
	$(NULL)
libtool_options = \
	$(NULL)
libtool_deps = \
	automake \
	$(NULL)
libtool_deps_for_build = \
	$(NULL)

gettext_version = 0.21
gettext_url = https://$(gnu_mirror)/gettext/gettext-$(gettext_version).tar.gz
gettext_hash = c77d0da3102aec9c07f43671e60611ebff89a996ef159497ce8e59d075786b12
gettext_recipe = autotools
gettext_patches = \
	gettext-static-only.patch \
	gettext-gnulib-glibc.patch \
	$(NULL)
gettext_options = \
	--disable-curses \
	$(NULL)
gettext_deps = \
	libtool \
	$(NULL)
gettext_deps_for_build = \
	$(NULL)

zlib_version = 91920caec2160ffd919fd48dc4e7a0f6c3fb36d2
zlib_url = $(frida_base_url)/zlib.git
zlib_hash = $(NULL)
zlib_recipe = meson
zlib_patches = \
	$(NULL)
zlib_options = \
	$(NULL)
zlib_deps = \
	$(NULL)
zlib_deps_for_build = \
	$(NULL)

libffi_version = b2ec2430601562a33e75470a3db044d4279b7955
libffi_url = $(frida_base_url)/libffi.git
libffi_hash = $(NULL)
libffi_recipe = meson
libffi_patches = \
	$(NULL)
libffi_options = \
	$(NULL)
libffi_deps = \
	$(NULL)
libffi_deps_for_build = \
	$(NULL)

selinux_version = 9c7ba053bb075cace088d268fda400f6bc4ab14c
selinux_url = $(frida_base_url)/selinux.git
selinux_hash = $(NULL)
selinux_recipe = meson
selinux_patches = \
	$(NULL)
selinux_options = \
	-Dregex=disabled \
	$(NULL)
selinux_deps = \
	$(NULL)
selinux_deps_for_build = \
	$(NULL)

glib_version = 6d3a90e5c670b4fb37633c0ac8c285c259615b3e
glib_url = $(frida_base_url)/glib.git
glib_hash = $(NULL)
glib_recipe = meson
glib_patches = \
	$(NULL)
glib_deps = \
	zlib \
	libffi \
	$(NULL)
glib_deps_for_build = \
	$(NULL)
glib_options = \
	-Dselinux=disabled \
	-Dxattr=false \
	-Dlibmount=disabled \
	-Dinternal_pcre=true \
	-Dtests=false \
	-Dglib_debug=disabled \
	-Dglib_assert=false \
	-Dglib_checks=false \
	$(NULL)
ifeq ($(host_os), $(filter $(host_os),macos ios))
# Use Apple's iconv by default to make our toolchain smaller.
# Our SDK will pull in its own.
glib_options += -Diconv=external
endif
ifeq ($(host_os), $(filter $(host_os),android qnx))
glib_options += -Diconv=external
glib_deps += libiconv
endif
ifeq ($(FRIDA_LIBC), uclibc)
glib_options += -Diconv=external
glib_deps += libiconv
endif

pkg_config_version = b7fb5edc1f1a4fb17cd5cb94f4cf21912184da43
pkg_config_url = $(frida_base_url)/pkg-config.git
pkg_config_hash = $(NULL)
pkg_config_recipe = meson
pkg_config_patches = \
	$(NULL)
pkg_config_options = \
	$(NULL)
pkg_config_deps = \
	glib \
	$(NULL)
pkg_config_deps_for_build = \
	$(NULL)

flex_version = 2.6.4
flex_url = https://github.com/westes/flex/releases/download/v$(flex_version)/flex-$(flex_version).tar.gz
flex_hash = e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995
flex_recipe = autotools
flex_patches = \
	flex-modern-glibc.patch \
	$(NULL)
flex_options = \
	$(NULL)
flex_deps = \
	m4 \
	$(NULL)
flex_deps_for_build = \
	$(NULL)

bison_version = 3.7.3
bison_url = https://$(gnu_mirror)/bison/bison-$(bison_version).tar.gz
bison_hash = 104fe912f2212ab4e4a59df888a93b719a046ffc38d178e943f6c54b1f27b3c7
bison_recipe = autotools
bison_patches = \
	$(NULL)
bison_options = \
	$(NULL)
bison_deps = \
	m4 \
	$(NULL)
bison_deps_for_build = \
	$(NULL)

vala_version = 2a249ddf14a85fb7da6769f2dfb04b9c15a13835
vala_url = $(frida_base_url)/vala.git
vala_hash = $(NULL)
vala_recipe = meson
vala_patches = \
	$(NULL)
vala_options = \
	$(NULL)
vala_deps = \
	glib \
	$(NULL)
vala_deps_for_build = \
	flex \
	bison \
	$(NULL)

elfutils_version = b503c358dde835d8a1ae3ebd4968755ff396f814
elfutils_url = git://sourceware.org/git/elfutils.git
elfutils_hash = $(NULL)
elfutils_recipe = custom
elfutils_patches = \
	elfutils-clang.patch \
	elfutils-android.patch \
	elfutils-glibc-compatibility.patch \
	elfutils-musl.patch \
	$(NULL)
elfutils_options = \
	--enable-maintainer-mode \
	--disable-libdebuginfod \
	--disable-debuginfod \
	$(NULL)
elfutils_deps = \
	xz \
	zlib \
	$(NULL)
elfutils_deps_for_build = \
	$(NULL)

libdwarf_version = 20201201
libdwarf_url = https://www.prevanders.net/libdwarf-$(libdwarf_version).tar.gz
libdwarf_hash = 62db1028dfd8fd877d01ae75873ac1fe311437012ef48a0ac4157189e1e9b2c9
libdwarf_recipe = custom
libdwarf_patches = \
	$(NULL)
libdwarf_options = \
	$(NULL)
libdwarf_deps = \
	elfutils \
	$(NULL)
libdwarf_deps_for_build = \
	$(NULL)

xz_version = 6c84113065f603803683d30342207c73465bbc12
xz_url = $(frida_base_url)/xz.git
xz_hash = $(NULL)
xz_recipe = autotools
xz_patches = \
	$(NULL)
xz_options = \
	$(NULL)
xz_deps = \
	$(NULL)
xz_deps_for_build = \
	$(NULL)

brotli_version = 753ac0f5855bcf8f980bd7c787ac56030b42db84
brotli_url = $(frida_base_url)/brotli.git
brotli_hash = $(NULL)
brotli_recipe = meson
brotli_patches = \
	$(NULL)
brotli_options = \
	$(NULL)
brotli_deps = \
	$(NULL)
brotli_deps_for_build = \
	$(NULL)

minizip_version = 4501ae619720d6769302eb792ae9389d878201f8
minizip_url = $(frida_base_url)/minizip.git
minizip_hash = $(NULL)
minizip_recipe = meson
minizip_patches = \
	$(NULL)
minizip_options = \
	-Dzlib=enabled \
	-Dlzma=disabled \
	$(NULL)
minizip_deps = \
	zlib \
	$(NULL)
minizip_deps_for_build = \
	$(NULL)
ifeq ($(host_os), $(filter $(host_os),macos ios android qnx))
minizip_deps += libiconv
endif
ifeq ($(FRIDA_LIBC), uclibc)
minizip_deps += libiconv
endif

sqlite_version = b67ff8d8344c355ec322e1a838dd204416483be2
sqlite_url = $(frida_base_url)/sqlite.git
sqlite_hash = $(NULL)
sqlite_recipe = meson
sqlite_patches = \
	$(NULL)
sqlite_options = \
	$(NULL)
sqlite_deps = \
	$(NULL)
sqlite_deps_for_build = \
	$(NULL)

libunwind_version = 6548fb3ba612847b967f682ea75f5dde2ec3f331
libunwind_url = $(frida_base_url)/libunwind.git
libunwind_hash = $(NULL)
libunwind_recipe = autotools
libunwind_patches = \
	$(NULL)
libunwind_options = \
	--disable-coredump \
	--disable-ptrace \
	--disable-setjmp \
	--disable-debug \
	--disable-msabi-support \
	--enable-minidebuginfo \
	--enable-zlibdebuginfo \
	$(NULL)
libunwind_deps = \
	zlib \
	xz \
	$(NULL)
libunwind_deps_for_build = \
	$(NULL)

glib_networking_version = 0ef1a69313d0143bb903c4de9f175f560123b93c
glib_networking_url = $(frida_base_url)/glib-networking.git
glib_networking_hash = $(NULL)
glib_networking_recipe = meson
glib_networking_patches = \
	$(NULL)
glib_networking_options = \
	-Dgnutls=disabled \
	-Dopenssl=enabled \
	-Dlibproxy=disabled \
	-Dgnome_proxy=disabled \
	-Dstatic_modules=true \
	$(NULL)
glib_networking_deps = \
	glib \
	openssl \
	$(NULL)
glib_networking_deps_for_build = \
	$(NULL)

libnice_version = a79e99251cd44cd1c8296422bf7c8314ae1ceb75
libnice_url = $(frida_base_url)/libnice.git
libnice_hash = $(NULL)
libnice_recipe = meson
libnice_patches = \
	$(NULL)
libnice_options = \
	-Dgupnp=disabled \
	-Dgstreamer=disabled \
	-Dcrypto-library=openssl \
	-Dexamples=disabled \
	-Dtests=disabled \
	-Dintrospection=disabled \
	$(NULL)
libnice_deps = \
	glib \
	openssl \
	$(NULL)
libnice_deps_for_build = \
	$(NULL)

usrsctp_version = 2020cb9c6cc1c26a848cd352d46ea36b11cacbe0
usrsctp_url = $(frida_base_url)/usrsctp.git
usrsctp_hash = $(NULL)
usrsctp_recipe = meson
usrsctp_patches = \
	$(NULL)
usrsctp_options = \
	-Dsctp_inet=false \
	-Dsctp_inet6=false \
	-Dsctp_build_programs=false \
	$(NULL)
usrsctp_deps = \
	$(NULL)
usrsctp_deps_for_build = \
	$(NULL)

libgee_version = efe80dbdc63fb5aeb4d0f6999fa19621efb1865c
libgee_url = $(frida_base_url)/libgee.git
libgee_hash = $(NULL)
libgee_recipe = meson
libgee_patches = \
	$(NULL)
libgee_options = \
	$(NULL)
libgee_deps = \
	glib \
	$(NULL)
libgee_deps_for_build = \
	$(NULL)

json_glib_version = a9b00c0c23709fa11df1ac60c1c7b5eb4596a600
json_glib_url = $(frida_base_url)/json-glib.git
json_glib_hash = $(NULL)
json_glib_recipe = meson
json_glib_patches = \
	$(NULL)
json_glib_options = \
	-Dintrospection=disabled \
	-Dgtk_doc=disabled \
	-Dtests=false \
	$(NULL)
json_glib_deps = \
	glib \
	$(NULL)
json_glib_deps_for_build = \
	$(NULL)

libpsl_version = 3caf6c33029b6c43fc31ce172badf976f6c37bc4
libpsl_url = $(frida_base_url)/libpsl.git
libpsl_hash = $(NULL)
libpsl_recipe = meson
libpsl_patches = \
	$(NULL)
libpsl_options = \
	-Druntime=no \
	-Dbuiltin=no \
	-Dtests=false \
	$(NULL)
libpsl_deps = \
	$(NULL)
libpsl_deps_for_build = \
	$(NULL)

libxml2_version = f1845f6fd1c0b6aac0f573c77a8250f8d4eb31fd
libxml2_url = $(frida_base_url)/libxml2.git
libxml2_hash = $(NULL)
libxml2_recipe = meson
libxml2_patches = \
	$(NULL)
libxml2_options = \
	$(NULL)
libxml2_deps = \
	zlib \
	xz \
	$(NULL)
libxml2_deps_for_build = \
	$(NULL)

libsoup_version = fecd985fa710fa494f62b7bfc9d0728185db2798
libsoup_url = $(frida_base_url)/libsoup.git
libsoup_hash = $(NULL)
libsoup_recipe = meson
libsoup_patches = \
	$(NULL)
libsoup_options = \
	-Dgssapi=disabled \
	-Dntlm=disabled \
	-Dbrotli=enabled \
	-Dtls_check=false \
	-Dgnome=false \
	-Dintrospection=disabled \
	-Dvapi=disabled \
	-Dtests=false \
	-Dsysprof=disabled \
	$(NULL)
libsoup_deps = \
	glib \
	sqlite \
	libpsl \
	libxml2 \
	brotli \
	$(NULL)
libsoup_deps_for_build = \
	$(NULL)

capstone_version = 5002dd1384ff716628ddc1a8914dd196c171109c
capstone_url = $(frida_base_url)/capstone.git
capstone_hash = $(NULL)
capstone_recipe = meson
capstone_patches = \
	$(NULL)
capstone_options = \
	-Darchs=$(capstone_archs) \
	-Dx86_att_disable=true \
	-Dcli=disabled \
	$(NULL)
capstone_deps = \
	$(NULL)
capstone_deps_for_build = \
	$(NULL)
capstone_archs := $(shell echo $(host_arch) | sed $(sed_regex_option) \
		-e 's,^x86_64$$,x86,' \
		-e 's,^arm[^0-9].+,arm,' \
		-e 's,^arm64e$$,arm64,' \
		-e 's,^arm64eoabi$$,arm64,' \
		-e 's,^mips.*,mips,' \
		-e 's,^s390x$$,sysz,' \
	)

quickjs_version = 923440e698c33753f8b054e33624680203d268e5
quickjs_url = $(frida_base_url)/quickjs.git
quickjs_hash = $(NULL)
quickjs_recipe = meson
quickjs_patches = \
	$(NULL)
quickjs_options = \
	-Dlibc=false \
	-Dbignum=true \
	-Datomics=disabled \
	-Dstack_check=disabled \
	$(NULL)
quickjs_deps = \
	$(NULL)
quickjs_deps_for_build = \
	$(NULL)

tinycc_version = 71c2e2c3d5009bf4ec0c242715250fdc772d49d1
tinycc_url = $(frida_base_url)/tinycc.git
tinycc_hash = $(NULL)
tinycc_recipe = meson
tinycc_patches = \
	$(NULL)
tinycc_options = \
	$(NULL)
tinycc_deps = \
	$(NULL)
tinycc_deps_for_build = \
	$(NULL)

openssl_version = 1.1.1k
openssl_url = https://www.openssl.org/source/openssl-$(openssl_version).tar.gz
openssl_hash = 892a0875b9872acd04a9fde79b1f943075d5ea162415de3047c327df33fbaee5
openssl_recipe = custom
openssl_patches = \
	openssl-android.patch \
	openssl-armcap.patch \
	openssl-windows.patch \
	$(NULL)
openssl_options = \
	--openssldir=/etc/ssl \
	no-dso \
	no-engine \
	no-tests \
	no-comp \
	no-ssl3 \
	no-zlib \
	no-async \
	no-shared \
	enable-cms \
	$(NULL)
openssl_deps = \
	$(NULL)
openssl_deps_for_build = \
	$(NULL)

v8_version = a19cd1873febc322a6783b548c9ceda1559fd140
v8_url = $(frida_base_url)/v8.git
v8_hash = $(NULL)
v8_recipe = custom
v8_patches = \
	$(NULL)
v8_options = \
	use_thin_lto=false \
	v8_monolithic=true \
	v8_use_external_startup_data=false \
	is_component_build=false \
	v8_enable_debugging_features=false \
	v8_enable_disassembler=false \
	v8_enable_gdbjit=false \
	v8_enable_i18n_support=false \
	v8_untrusted_code_mitigations=false \
	treat_warnings_as_errors=false \
	fatal_linker_warnings=false \
	use_glib=false \
	use_goma=false \
	v8_embedder_string="-frida" \
	$(NULL)
v8_deps = \
	$(NULL)
v8_deps_for_build = \
	$(NULL)
v8_api_version = 8.0

gn_version = 75194c124f158d7fabdc94048f1a3f850a5f0701
gn_url = $(frida_base_url)/gn.git
gn_hash = $(NULL)
gn_recipe = custom
gn_patches = \
	$(NULL)
gn_options = \
	$(NULL)
gn_deps = \
	$(NULL)
gn_deps_for_build = \
	$(NULL)

depot_tools_version = b674f8a27725216bd2201652636649d83064ca4a
depot_tools_url = https://chromium.googlesource.com/chromium/tools/depot_tools.git
depot_tools_hash = $(NULL)
depot_tools_recipe = custom
depot_tools_patches = \
	$(NULL)
depot_tools_options = \
	$(NULL)
depot_tools_deps = \
	$(NULL)
depot_tools_deps_for_build = \
	$(NULL)


define expand-packages
$(sort $(foreach pkg, $1, $(pkg) $($(subst -,_,$(pkg))_deps) $($(subst -,_,$(pkg))_deps_for_build)))
endef


define make-package-rules

$(foreach pkg, $(call expand-packages,$1), \
	$(if $(findstring meson,$($(subst -,_,$(pkg))_recipe)), $(call make-meson-package-rules,$(pkg),$2), \
	$(if $(findstring autotools,$($(subst -,_,$(pkg))_recipe)), $(call make-autotools-package-rules,$(pkg),$2),)))

endef


define make-meson-package-rules

$(call make-base-package-rules,$1,$2,$(host_os_arch))

deps/.$1-stamp:
	$$(call grab-and-prepare,$1)
	@touch $$@

build/$2-%/manifest/$1.pkg: build/$2-env-%.rc deps/.$1-stamp \
		$(foreach dep, $($(subst -,_,$1)_deps), build/$2-%/manifest/$(dep).pkg) \
		$(foreach dep, $($(subst -,_,$1)_deps_for_build), build/$2-$(build_os_arch)/manifest/$(dep).pkg) \
		releng/meson/meson.py
	@$(call print-status,$1,Building)
	@prefix=$$(abspath build/$2-$$*); \
	builddir=build/$2-tmp-$$*/$1; \
	$(RM) -r $$$$builddir; \
	mkdir -p $$$$builddir; \
	(set -x \
		&& . build/$2-meson-env-$$*.rc \
		&& export PATH="$$(abspath build/$2-$(build_os_arch))/bin:$$$$PATH" \
		&& $(call print-status,$1,Configuring) \
		&& $(MESON) \
			--cross-file build/$2-$$*.txt \
			--prefix "$$$$prefix" \
			--libdir "$$$$prefix/lib" \
			--default-library static \
			$$(FRIDA_MESONFLAGS_BOTTLE) \
			$$($$(subst -,_,$1)_options) \
			$$$$builddir \
			deps/$1 \
		&& $(NINJA) -C $$$$builddir install \
	) >$$$$builddir/build.log 2>&1 \
	&& $(call print-status,$1,Generating manifest) \
	&& (set -x \
		&& cd $$$$builddir \
		&& mkdir -p "$$$$prefix/manifest" \
		&& $(MESON) introspect --installed --indent \
			| grep ": " \
			| cut -f4 -d'"' \
			| cut -c$$(strip $$(shell echo $$(abspath build/$2-$$*)x | wc -c))- \
			| sort \
			> "$$$$prefix/manifest/$1.pkg" \
	) >>$$$$builddir/build.log 2>&1 || (echo "failed - see $$$$builddir/build.log for more information"; exit 1) \

endef


define make-autotools-package-rules

$(call make-autotools-package-rules-without-build-rule,$1,$2)

$(call make-autotools-build-rule,$1,$2)

endef


define make-autotools-package-rules-without-build-rule

$(call make-base-package-rules,$1,$2,$(host_os_arch))

deps/.$1-stamp:
	$$(call grab-and-prepare,$1)
	@touch $$@

$(call make-autotools-autoreconf-rule,$1,$2)

$(call make-autotools-configure-rule,$1,$2)

endef


define make-autotools-autoreconf-rule

deps/$1/configure: build/$2-env-$(build_os_arch).rc deps/.$1-stamp
	@. $$< \
		&& cd $$(@D) \
		&& if [ ! -f configure ] || [ -f ../.$1-reconf-needed ]; then \
			$(call print-status,$1,Generating build system); \
			autoreconf -if &>/dev/null || exit 1; \
			rm -f ../.$1-reconf-needed; \
		fi
	@touch $$@

endef


define make-autotools-configure-rule

build/$2-tmp-%/$1/Makefile: build/$2-env-%.rc deps/$1/configure deps/.$1-stamp \
		$(foreach dep, $($(subst -,_,$1)_deps), build/$2-%/manifest/$(dep).pkg) \
		$(foreach dep, $($(subst -,_,$1)_deps_for_build), build/$2-$(build_os_arch)/manifest/$(dep).pkg)
	@$(call print-status,$1,Configuring)
	@$(RM) -r $$(@D)
	@mkdir -p $$(@D)
	@(set -x \
		&& . $$< \
		&& export PATH="$$(abspath build/$2-$(build_os_arch))/bin:$$$$PATH" \
		&& cd $$(@D) \
		&& ../../../deps/$1/configure $$($$(subst -,_,$1)_options) \
	) >$$(@D)/build.log 2>&1 || (echo "failed - see $$(@D)/build.log for more information"; exit 1)

endef


define make-autotools-build-rule

build/$2-%/manifest/$1.pkg: build/$2-env-%.rc build/$2-tmp-%/$1/Makefile
	@$(call print-status,$1,Building)
	@builddir=build/$2-tmp-$$*/$1; \
	(set -x \
		&& . $$< \
		&& export PATH="$$(abspath build/$2-$(build_os_arch))/bin:$$$$PATH" \
		&& cd "$$$$builddir" \
		&& $(MAKE) $(MAKE_J) \
		&& $(MAKE) $(MAKE_J) install \
	) >>$$$$builddir/build.log 2>&1 \
	&& $(call print-status,$1,Generating manifest) \
	&& (set -x; \
		$$(call make-autotools-manifest-commands,$1,$2,$$*,) \
	) >>$$$$builddir/build.log 2>&1 || (echo "failed - see $$$$builddir/build.log for more information"; exit 1)

endef


define make-autotools-manifest-commands
	( \
		prefix=$(abspath build/$2-$3) \
		&& mkdir -p $$prefix/manifest \
		&& cd build/$2-tmp-$3/$1 \
		&& $(RM) -r __pkg__ \
		&& mkdir __pkg__ \
		&& $(MAKE) $(MAKE_J) $(if $4,$4,install) DESTDIR="$(abspath build/$2-tmp-$3/$1/__pkg__)" &>/dev/null \
		&& cd __pkg__ \
		&& find . -type f \
			| cut -c$(strip $(shell echo $(abspath build/$2-$3)xx | wc -c))- \
			| sort \
			> "$$prefix/manifest/$1.pkg" \
		&& $(RM) -r __pkg__ \
	)
endef


define make-base-package-rules

$(call make-build-incremental-package-rule,$1,$2,$3)

$(call make-clean-package-rules,$1,$2,$3)

$(call make-symlinks-package-rule,$1,$2,$3)

endef


define make-build-incremental-package-rule

.PHONY: $1

$1: build/$2-$3/manifest/$1.pkg
	builddir=build/$2-tmp-$3/$1; \
	export PATH="$$(abspath build/$2-$(build_os_arch))/bin:$$$$PATH"; \
	if [ -f deps/$1/meson.build ]; then \
		. build/$2-meson-env-$3.rc; \
		$(NINJA) -C $$$$builddir install; \
	else \
		. build/$2-env-$3.rc; \
		$(MAKE) -C $$$$builddir $(MAKE_J) install; \
	fi

endef


define make-clean-package-rules

.PHONY: clean-$1 distclean-$1

clean-$1:
	@if [ -f build/$2-$3/manifest/$1.pkg ]; then \
		cd build/$2-$3; \
		cat manifest/$1.pkg | while read entry; do \
			echo $(RM) build/$2-$3/$$$$entry; \
			$(RM) $$$$entry; \
			rmdir -p $$$$(dirname $$$$entry) 2>/dev/null || true; \
		done \
	fi
	$(RM) build/$2-$3/manifest/$1.pkg
	$(RM) -r build/$2-tmp-$3/$1

distclean-$1: clean-$1
	$(RM) deps/.$1-stamp
	$(RM) -r deps/$1

endef


define make-symlinks-package-rule

.PHONY: symlinks-$1

symlinks-$1: build/$2-$3/manifest/$1.pkg
	@sdkroot=build/sdk-$$(host_os_arch); \
	if [ -d $$$$sdkroot ]; then \
		cd $$$$sdkroot; \
		if [ -f manifest/$1.pkg ]; then \
			for old_entry in $$$$(cat manifest/$1.pkg); do \
				$(RM) $$$$old_entry; \
			done; \
		fi; \
		for entry in $$$$(cat ../$2-$3/manifest/$1.pkg); do \
			echo "✓ $$$$entry"; \
			$(RM) $$$$entry; \
			mkdir -p $$$$(dirname $$$$entry); \
			original_relpath=$$$$($(PYTHON3) -c "import os.path; import sys; \
				print(os.path.relpath('../$2-$3/$$$$entry', os.path.dirname('$$$$entry')))"); \
			ln -s $$$$original_relpath $$$$entry; \
		done; \
	fi

endef


define grab-and-prepare
	$(if $($(subst -,_,$1)_hash),
		$(call grab-and-prepare-tarball,$1),
		$(call grab-and-prepare-repo,$1))
endef


define grab-and-prepare-tarball
	@$(RM) -r deps/$1
	@mkdir -p deps/$1

	@url=$($(subst -,_,$1)_url) \
		&& version=$($(subst -,_,$1)_version) \
		&& expected_hash=$($(subst -,_,$1)_hash) \
		&& $(call print-tarball-banner,$1,$$version,$$url,$$expected_hash) \
		&& $(call print-status,$1,Downloading) \
		&& if command -v curl >/dev/null; then \
			curl -sSfLo deps/.$1-tarball $$url; \
		else \
			wget -qO deps/.$1-tarball $$url; \
		fi \
		&& $(call print-status,$1,Verifying) \
		&& actual_hash=$$(shasum -a 256 -b deps/.$1-tarball | awk '{ print $$1; }') \
		&& case $$actual_hash in \
			$$expected_hash) \
				;; \
			*) \
				echo "$1 tarball is corrupted; its hash is: $$actual_hash"; \
				exit 1; \
				;; \
		esac

	@$(call print-status,$1,Extracting to deps/$1)
	@tar -C deps/$1 -x -f deps/.$1-tarball -z --strip-components 1

	$(call apply-patches,$1)

	@rm deps/.$1-tarball
endef


define grab-and-prepare-repo
	@$(RM) -r deps/$1

	@url=$($(subst -,_,$1)_url) \
		&& version=$($(subst -,_,$1)_version) \
		&& $(call print-repo-banner,$1,$$version,$$url) \
		&& $(call print-status,$1,Cloning into deps/$1) \
		&& git clone -q --recurse-submodules $$url deps/$1 \
		&& cd deps/$1 \
		&& git checkout -q $$version

	$(call apply-patches,$1)
endef


define apply-patches
	@cd deps/$1 \
		&& for patch in $($(subst -,_,$1)_patches); do \
			file=../../releng/patches/$$patch; \
			\
			$(call print-status,$1,Applying $$patch); \
			patch -p1 < $$file &>/dev/null || exit 1; \
			\
			if grep '+++' $$file | grep -Eq 'configure\.ac|Makefile\.am'; then \
				touch ../.$1-reconf-needed; \
			fi \
		done
endef


define print-status
	echo -e "│ \\033[1m$1\\033[0m :: $2"
endef


define print-tarball-banner
	echo -e "\n╭────\n│ 📦 \\033[1m$1\\033[0m $2\n├───────\n│ URL: $3\n│ SHA: $4\n├────────────"
endef


define print-repo-banner
	echo -e "\n╭────\n│ 📦 \\033[1m$1\\033[0m\n├───────────────────────────────────────────────╮\n│ URL: $3\n│ CID: $2\n├───────────────────────────────────────────────╯"
endef
