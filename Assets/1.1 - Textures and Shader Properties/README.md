# 1.1 - Textures and Shader Properties

In this example, we are going to explore more shader functions and properties. The effect you will be creating is a brick ball with texture and normal map, as well as an option to add a rim lighting (i.e. light color at the edge of the object):

Without rim lighting:

![no_rim](/DemoImages/1.1.0.png)

With rim lighting:

![rim](/DemoImages/1.1.1.png)

The code you need to understand is located in [TexturedShader.shader](TexturedShader.shader).

## Shader Properties

Properties are values that can be passed into the shader to be referenced. These are the properties you see in a standard material's inspector (smoothness, normal map, albedo, etc). This example declares properties for the albedo map (texture) and normal map, as well as options for the rim color and intensity.

## Concepts

This example also introduces new concepts such as normals and viewing vectors. Let's take a quick look at those.

### Normal

A normal vector at a point on the surface of an object is the direction the surface is facing in. In other words, the normal vector is perpendicular to the tangent line. Normal is used mainly for light calculations, such as reflection. In this example, it is used to determine which 'pixels' are facing sideways in respect to the camera's viewing direction, and color them by assigning a higher emission value (rim lighting). A normal vector is always normalized (has a magnitude of 1).

### Viewing Direction

The viewing direction is simply the direction the camera is facing in (i.e. the forward vector of the camera). It is commonly used to calculate lightings that are dependent on the viewing angle.