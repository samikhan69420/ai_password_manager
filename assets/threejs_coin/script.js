import * as THREE from 'three';
import { OrbitControls } from 'jsm/controls/OrbitControls.js';
import gsap from 'gsap';


const scene = new THREE.Scene();
scene.background = new THREE.Color(0x000000);


const aspect = window.innerWidth / window.innerHeight;
const cameraSize = 3; 
const camera = new THREE.OrthographicCamera(
  -cameraSize * aspect, 
  cameraSize * aspect, 
  cameraSize, 
  -cameraSize, 
  0.1, 
  100 
);
const originalPosition = new THREE.Vector3(1, -1, 2); 
const originalTarget = new THREE.Vector3(0, 0, 0); 

camera.position.copy(originalPosition);
camera.lookAt(originalTarget);

const renderer = new THREE.WebGLRenderer({antialias: true});
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);


const shape = new THREE.Shape();
shape.absarc(0, 0, 1.5, 0, Math.PI * 2, false); 


const extrudeSettings = {
  depth: 1, 
  bevelEnabled: true, 
  bevelThickness: 0.05, 
  bevelSize: 0.05, 
  bevelSegments: 5, 
};


const geometry = new THREE.ExtrudeGeometry(shape, extrudeSettings);


const faceMaterial = new THREE.MeshBasicMaterial({ color: 0xffffff });


const edgeMaterial = new THREE.MeshBasicMaterial({ color: 0x000000 });


const mesh = new THREE.Mesh(geometry, [edgeMaterial, faceMaterial]);
scene.add(mesh);


const light = new THREE.PointLight(0xffffff, 1, 100);
light.position.set(10, 10, 10);
scene.add(light);


const outlineGeometry = new THREE.EdgesGeometry(geometry);
const outlineMaterial = new THREE.LineBasicMaterial({
  color: 0xffffff,
  linewidth: 2,
});
const outline = new THREE.LineSegments(outlineGeometry, outlineMaterial);
scene.add(outline);


const controls = new OrbitControls(camera, renderer.domElement);
controls.enableDamping = true; 
controls.dampingFactor = 0.05;
controls.rotateSpeed = 0.8; 
controls.enableZoom = true; 
controls.enablePan = true; 


function resetCameraWithSpring() {
  gsap.to(camera.position, {
    x: originalPosition.x,
    y: originalPosition.y,
    z: originalPosition.z,
    duration: 1, 
    ease: 'elastic.out(1, 0.5)', 
    onUpdate: () => camera.lookAt(originalTarget), 
  });
}


let mouseDown = false;


window.addEventListener('mousedown', () => {
  mouseDown = true;
});

window.addEventListener('mouseup', () => {
  if (mouseDown) {
    resetCameraWithSpring();
  }
  mouseDown = false;
});


window.addEventListener('resize', () => {
  const aspect = window.innerWidth / window.innerHeight;
  camera.left = -cameraSize * aspect;
  camera.right = cameraSize * aspect;
  camera.top = cameraSize;
  camera.bottom = -cameraSize;
  camera.updateProjectionMatrix();
  renderer.setSize(window.innerWidth, window.innerHeight);
});


function animate() {
  requestAnimationFrame(animate);
  controls.update(); 
  renderer.render(scene, camera);
}
animate();
