TEMPLATE = app

QT += qml quick widgets declarative opengl location positioning multimedia
#QT += webkit
#QT += 3dcore 3drenderer 3dinput 3dquick
QT += webengine

TARGET.CAPABILITY += SwEvent

SOURCES += main.cpp \
    resserver.cpp \
    filereader.cpp \
    window.cpp \
    qmlhelper.cpp

RESOURCES += qml.qrc
#RESOURCES += 3d.qrc
RESOURCES += pics.qrc
RESOURCES += res.qrc

RC_FILE = res.rc

#not enough to make it work on virtual-xp
#win32 {
#    QMAKE_LFLAGS_WINDOWS = /SUBSYSTEM:WINDOWS,5.01
#    QMAKE_LFLAGS_CONSOLE = /SUBSYSTEM:CONSOLE,5.01
#
#    DEFINES += _ATL_XP_TARGETING
#    QMAKE_CFLAGS += /D _USING_V110_SDK71
#    QMAKE_CXXFLAGS += /D _USING_V110_SDK71
#    QMAKE_CFLAGS += /D _USING_V110_SDK71_
#    QMAKE_CXXFLAGS += /D _USING_V110_SDK71_
#    LIBS *= -L”%ProgramFiles(x86)%/Microsoft SDKs/Windows/7.1A/Lib”
#    INCLUDEPATH += “%ProgramFiles(x86)%/Microsoft SDKs/Windows/7.1A/Include”
#}

OTHER_FILES += \
                ico.ico res.rc \
		main.qml \
		README.md \
                js/main.js \
                js/LoginForm.js \
		src/variables/base.js \
		src/variables/buttons.js \
		src/variables/colors.js \
		src/variables/items.js \
		src/variables/badges.js \
		src/variables/fontawesome.js \
		src/styles/TouchStyle.qml \
		src/buttons/ButtonDefault.qml \        
		src/styles/TouchOutlineStyle.qml \
		src/styles/ListDividerStyle.qml \
		src/lists/List.qml \
		src/lists/DefaultListView.qml \
		src/lists/IconListView.qml \
		src/styles/DefaulListViewStyle.qml \
		src/styles/IconListViewStyle.qml \
		src/examples/ButtonPage.qml \
		src/examples/DefaultListPage.qml \
		src/examples/IconListPage.qml \
    src/lists/AvatarListView.qml \
    src/styles/AvatarListViewStyle.qml \
    src/examples/AvatarListPage.qml \
    src/content/TextContent.qml \
    src/styles/ThumbnailListViewStyle.qml \
    src/lists/ThumbnailListView.qml \
    src/examples/ThumbnailListPage.qml \
    src/styles/TouchClearStyle.qml \
    src/bars/Bar.qml \
    src/variables/bars.js \
    src/bars/ButtonBar.qml \
    src/examples/ButtonBarPage.qml \
    src/cards/Card.qml \
    src/styles/CardStyle.qml \
    src/examples/CardPage.qml \
    Bunny3DExplorer.qml
#    3d/SortedForwardRenderer.qml \
#    3d/BasicCamera.qml \
#    3d/PlaneEntity.qml \
#    3d/RenderableEntity.qml \
#    3d/TrefoilKnot.qml \
#    3d/WireframeEffect.qml \
#    3d/WireframeMaterial.qml \
#    3d/Scene.qml \
#    3d/ControlEventSource.qml



# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =
QMAKE_MAC_SDK = macosx10.9
# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    LoginForm.qml \
    android/res/drawable-hdpi/icon.png \
    android/res/drawable-ldpi/icon.png \
    android/res/drawable-mdpi/icon.png \
    android/gradle.properties \
    android/local.properties \
    CurtainEffect.qml \
    FunctionChooser.qml \
    Functions.qml \
    BunnyCoverFlow.qml \
    js/BunnyCoverFlowJs.js \
    js/Fans.js \
    BunnyVideo.qml \
    SeekControl.qml \
    Effect.qml \
    EffectPageCurl.qml \
    Bunny3DExplorer.qml
#    3d/SortedForwardRenderer.qml \
#    3d/BasicCamera.qml \
#    3d/PlaneEntity.qml \
#    3d/RenderableEntity.qml \
#    3d/TrefoilKnot.qml \
#    3d/WireframeEffect.qml \
#    3d/WireframeMaterial.qml \
#    3d/Scene.qml \
#    js/rabbit3dexplorer.js \
#    3d/ControlEventSource.qml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

HEADERS += \
    resource.h \
    resserver.h \
    filereader.h \
    window.h \
    qmlhelper.h

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_EXTRA_LIBS = \
        $$PWD/../../openssl4android/arm7-abi.4.9/libcrypto.so \
        $$PWD/../../openssl4android/arm7-abi.4.9/libssl.so
}
