Qt.include("three.js")
Qt.include("MTLLoader.js")
Qt.include("OBJLoader.js")

var camera, scene, renderer, cubeCamera;
var lea = null;
var zeroVector = new THREE.Vector3(0, 0, 0);
var cameraLight;
var sphereImage;
var textureLoader = new THREE.TextureLoader();
var isAndroid = false;  //TODO: check if 'qml: THREE.Canvas3DRenderer: image is not power of two' for 'carpet_diffuse.jpg' is a breaking issue on Android

function degToRad(degrees)
{
    return degrees * Math.PI / 180;
}

function initializeGL(canvas, textureSource)
{
    scene = new THREE.Scene();

    cubeCamera = new THREE.CubeCamera(5, 100, 512);
    cubeCamera.renderTarget.texture.minFilter = THREE.LinearMipMapLinearFilter;
    scene.add(cubeCamera);

    // Background sphere
    var sphere = new THREE.Mesh(
                    new THREE.SphereGeometry(40, 16, 16),
                    new THREE.MeshBasicMaterial()
                );
    sphere.side = THREE.BackSide;
    sphere.scale.x = -1;
    scene.add(sphere);
    if (sphereImage)
    {
        var sphereTexture = textureLoader.load(sphereImage, updateEnvMap);
        sphereTexture.mapping = THREE.UVMapping;
        sphereTexture.minFilter = THREE.LinearFilter;
        sphere.material.map = sphereTexture;
    }
    else
    {
        sphere.material.color = new THREE.Color("black");
    }

    camera = new THREE.PerspectiveCamera( 75, canvas.width / canvas.height, 0.001, 1000 );

    var light = new THREE.AmbientLight( 0xffffff );
    scene.add( light );

    cameraLight = new THREE.DirectionalLight( 0xffffff, 1 );
    cameraLight.position.y = 1.5;
    scene.add( cameraLight );

    renderer = new THREE.Canvas3DRenderer(
                { canvas: canvas, antialias: true, devicePixelRatio: canvas.devicePixelRatio });
    renderer.setSize( canvas.width, canvas.height );

    makeBunny();
}
function makeBunny()
{
    //LOAD MESH(ES)
    var mtlLoader = new THREE.MTLLoader();
    mtlLoader.setPath('');
    mtlLoader.load( 'lea.mtl', function( materials )
    {
        materials.preload();

        var objLoader = new THREE.OBJLoader();
        objLoader.setMaterials( materials );
        objLoader.setPath('');
        objLoader.load( 'lea.obj', function ( _lea )
        {
            lea = _lea;

            lea.scale.set(0.7, 0.7, 0.7);
            lea.translateX(-12);
            lea.translateZ(-12);

            lea.name = "lea";
            lea.rotation.x = 4.7;
            lea.rotation.y = -4.7;

            updateEnvMap();

            addFloor(lea);
            scene.add( lea );
        });
    });
}

function addFloor(lea)
{
    if(isAndroid) return;

    var geometry = new THREE.PlaneGeometry( 17/*width*/, 15/*height*/);
    geometry.computeFaceNormals();

    var material = null;//new THREE.MeshBasicMaterial( {color: 0x823628, side: THREE.DoubleSide} );
    {
        var grassTexture = textureLoader.load("qrc:/carpet_diffuse.jpg", updateEnvMap);
        grassTexture.mapping = THREE.UVMapping;
        grassTexture.minFilter = THREE.LinearFilter;
        grassTexture.wrapS = THREE.RepeatWrapping;
        grassTexture.wrapT = THREE.RepeatWrapping;
        material = new THREE.MeshLambertMaterial({ map : grassTexture });
    }

    var floorMesh = new THREE.Mesh( geometry, material );
    floorMesh.translateZ(1.8);//rights
    lea.add( floorMesh );
}

function updateEnvMap()
{
    if (lea)
    {
        // Take a snapshot of the scene using cube camera to create environment map for case
        if (lea.material)
            lea.material.envMap = cubeCamera.renderTarget;
        if(cubeCamera)cubeCamera.updateCubeMap(renderer, scene);
        if (lea.material)
            lea.material.needsUpdate = true;
    }
}

//called from QML
function setSphereTexture(image)
{
    sphereImage = image;
}
function resizeGL(canvas)
{
    camera.aspect = canvas.width / canvas.height;
    camera.updateProjectionMatrix();
    renderer.setPixelRatio(canvas.devicePixelRatio);
    renderer.setSize( canvas.width, canvas.height );
}

function paintGL(canvas)
{
    if (lea)
    {
        var cameraRad = degToRad(canvas.cameraAngle);
        var lightRad = cameraRad - 0.8;

        camera.position.x = canvas.distance * Math.sin(cameraRad);
        camera.position.z = canvas.distance * Math.cos(cameraRad);

        if(lea)
        {
            //lea.rotation.x = degToRad(canvas.xRotAnim);
            //lea.rotation.y = degToRad(canvas.yRotAnim);
            //lea.rotation.z = degToRad(canvas.zRotAnim);

            //lea.rotation.x = camera.rotation.x;
            lea.rotation.y = camera.rotation.y;
            lea.rotation.z = camera.rotation.z;

            lea.position.x = (-camera.position.x) * 9;
            lea.position.x = (-camera.position.x) * 9;
            lea.position.z = (-camera.position.z) * 3;
        }

        cameraLight.position.x = (canvas.distance + 2) * Math.sin(lightRad);
        cameraLight.position.z = (canvas.distance + 2) * Math.cos(lightRad);
        camera.lookAt(zeroVector);
    }

    renderer.render( scene, camera );
}
