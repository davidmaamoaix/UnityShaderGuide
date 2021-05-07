# 1.0 - Hello to Surface Shaders

Welcome to your first shader example!

I assume you already know what a shader is. If not, it's just a program that runs on the GPU. Shaders are commonly used in rendering to speed up computationally expensive operations, such as processing lighting or changing vertices.

The first chapter focuses on [Surface Shaders](https://docs.unity3d.com/Manual/SL-SurfaceShaders.html). Surface shaders are a streamlined way of writing shaders that interacts with lighting. You can think of surface shaders as programs that run once per pixel on an object and decide the specific color of that pixel (this is not technically accurate, but it is easier to see it this way for now).

Our first shader is very simple; it just changes the color of objects over time:

![sphere](/DemoImages/1.0.0.png)

The code you need to understand is located in [ColorChangingShader.shader](ColorChangingShader.shader).

Once you have written a shader, it is time to associate it to a [Material](https://docs.unity3d.com/Manual/Materials.html). Create a new material and change its shader to the one you just created in the shader drop-down:

![shader_menu](/DemoImages/1.0.1.png)

Assign the new material to a `GameObject`, and it should be changing color!