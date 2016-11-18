#------------ ensure valid commands ------

# 0: target is "all" and build variant is "debug"
# 1: if command is one of the valid build variants, target is "all" and build variant is whatever is specified
#	or, if command is not a build variant, target is whatever is specified and build variant is "debug"
# 2: both target and build variant are whatever has been specified

ifeq ($(findstring $(words $(MAKECMDGOALS)),0 1 2), )
	$(error invalid commands passed to make; require 0, 1 or 2 commands)
endif

#------------ build variant --------------

build :=
build_variants := debug release
default_build := debug

# if there are 2 commands, 1 of them has to be a build variant
ifeq ($(findstring $(words $(MAKECMDGOALS)),2),2)
	build := $(filter $(build_variants),$(MAKECMDGOALS))
	ifeq "$(build)" ""
		$(error 2 commands passed to make, 1 must be the build variant. Specify one of [$(strip $(build_variants))])
	endif
# if there is only 1 command, it might be the build variant (and implicit all)
else ifeq ($(findstring $(words $(MAKECMDGOALS)),1),1)
	build := $(filter $(build_variants),$(MAKECMDGOALS))
endif

# if no build has been specified, then we will build the default build
ifeq "$(build)" ""
	build:=$(default_build)
endif

building := $(if $(filter $(build_variants),$(build)),1,0)
ifneq "$(building)" "1"
	$(error Invalid build variant, specify one of [$(subst $(space),$(,) ,$(strip $(build_variants)))])
endif

#------------ target ---------------------

target := $(filter-out $(build),$(MAKECMDGOALS))

#------------ build dir ------------------

define find_project_root
	$(if $(wildcard $1/.git),$1,$(call find_project_root,$(abspath $1/..)))
endef

project_root := $(strip $(call find_project_root,$(shell pwd)))
build_stem := $(subst $(project_root),,$(shell pwd))
build_root := $(project_root)/.build/$(build)
build_dir := $(build_root)$(build_stem)

#-----------------------------------------

.PHONY: all $(target) $(build_variants)

all:
	@$(MAKE) --no-print-directory -C $(build_dir) $(MAKEFLAGS)

$(target):
	@$(MAKE) --no-print-directory -C $(build_root) $(target) $(MAKEFLAGS)

$(build): $(if $(target),,all)
	@touch /dev/null # rule which does nothing; suppresses "Nothing to be done for target"
