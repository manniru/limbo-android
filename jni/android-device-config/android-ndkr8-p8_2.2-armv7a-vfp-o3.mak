NDK_BASE=/media/data/home/tools/android-ndk-r8
NDK_PLATFORM=platforms/android-8
TOOLCHAIN_DIR=/media/data/home/tools/android-ndk-r8/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86
CC = $(TOOLCHAIN_DIR)/bin/arm-linux-androideabi-gcc
AR = $(TOOLCHAIN_DIR)/bin/arm-linux-androideabi-ar
LNK = $(TOOLCHAIN_DIR)/bin/arm-linux-androideabi-g++
STRIP = $(TOOLCHAIN_DIR)/bin/arm-linux-androideabi-strip
AR_FLAGS = crs
SYS_ROOT = --sysroot=$(NDK_BASE)/$(NDK_PLATFORM)/arch-arm
NDK_INCLUDE=arch-arm/usr/include
GCC_STATIC = $(NDK_BASE)/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/lib/gcc/arm-linux-androideabi/4.4.3/armv7-a/libgcc.a
USR_LIB = -L$(NDK_BASE)/$(NDK_PLATFORM)/arch-arm/usr/lib
SYSTEM_INCLUDE = \
    -I./qemu/linux-headers \
    -I$(NDK_BASE)/$(NDK_PLATFORM)/arch-arm/usr/include 
    
## OPTIONAL OPTIMIZATION FLAGS
OPTIM = \
-ffloat-store \
-ffast-math \
-fno-rounding-math \
-fno-signaling-nans \
-fcx-limited-range \
-fno-math-errno \
-funsafe-math-optimizations \
-fassociative-math \
-freciprocal-math \
-fassociative-math \
-freciprocal-math \
-ffinite-math-only \
-fno-signed-zeros \
-fno-trapping-math \
-frounding-math \
-fsingle-precision-constant \
-fcx-limited-range \
-fcx-fortran-rules


### CONFIGURATIONS

ANDROID_DEBUG_FLAGS = -g

# 9. Utilizing VFP
# This abi should try the hard float (FPU) on board but also keep compatibility
#   with Android libraries (soft)
# ANDROID NDK: Still SLOWWWWWWWWWWWWWWW
# LINARO Android toolchain supports VFP
ARCH_CFLAGS = \
-std=gnu99 \
-march=armv7-a \
-mfloat-abi=softfp -mfpu=vfp \
-O3 \
-Wno-psabi \
-fpic -ffunction-sections \
-fomit-frame-pointer -fno-strict-aliasing -finline-limit=64 \
-fstrength-reduce \
-ffast-math -fforce-addr -foptimize-sibling-calls \
-funsafe-math-optimizations -fno-trapping-math \
$(ANDROID_DEBUG_FLAGS)

# Not supported
#-fforce-mem

# To suppress looking in stadnard includes for the toolchain
#-nostdinc \

# for Debugging only
#-funwind-tables 

# SLows down
# -fstack-protector

# ORIGINAL CFLAGS FROM ANDROID NDK
#-D__ARM_ARCH_5__ -D__ARM_ARCH_5T__ -D__ARM_ARCH_5E__ -D__ARM_ARCH_5TE__  \
#-march=armv5te -mtune=xscale -msoft-float -mthumb \
#-Os
#-fpic -ffunction-sections -funwind-tables -fstack-protector \
#-Wno-psabi 
#-fomit-frame-pointer -fno-strict-aliasing -finline-limit=64 