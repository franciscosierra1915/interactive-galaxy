uniform float uTime;
uniform float uSize;
attribute vec3 aRandomness;
attribute float aScale;
varying vec3 vColor;

// uniform float uRandom;
// attribute vec3 offset;
// attribute float pindex;

float random(float n) {
	return fract(sin(n) * 43758.5453123);
}


void main()
{
    /**
     * Position
     */
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);
                
    // Rotate
    float angle = atan(modelPosition.x, modelPosition.z);
    float distanceToCenter = length(modelPosition.xz);
    float angleOffset = (1.0 / distanceToCenter) * uTime;
    angle += angleOffset;
    modelPosition.x = cos(angle) * distanceToCenter;
    modelPosition.z = sin(angle) * distanceToCenter;

    // Randomness
    modelPosition.xyz += aRandomness;

    // // displacement
	// vec3 displaced = offset;
	// // randomise
	// displaced.xy += vec2(random(pindex) - 0.5, random(offset.x + pindex) - 0.5) * uRandom;
	// float rndz = (random(pindex) + snoise_1_2(vec2(pindex * 0.1, uTime * 0.1)));
	// displaced.z += rndz * (random(pindex) * 2.0 * uDepth);
	// // center
	// displaced.xy -= uTextureSize * 0.5;

	// // touch
	// float t = texture2D(uTouch, puv).r;
	// displaced.z += t * 20.0;
	// displaced.x += cos(angle) * t * 20.0;
	// displaced.y += sin(angle) * t * 20.0;
    

    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;
    gl_Position = projectedPosition;

    /**
     * Size
     */
    gl_PointSize = uSize * aScale;
    gl_PointSize *= (1.0 / - viewPosition.z);

    /**
     * Color
     */
    vColor = color;
}