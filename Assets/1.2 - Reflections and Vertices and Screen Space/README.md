# 1.2 - Reflections and Vertices and Screen Space

This example explores some more functions such as using the reflection cube map and using screen-space coordinates. Vertex shaders are also going to be introduced.

Unlike the previous examples, this one has quite a few shaders. To organize things a little, imported resources are located under the [Resources](Resources/) subdirectory; shaders are under the [Shaders](Shaders/) subdirectory; materials are under the [Materials](Materials/) directory.

This example uses a llama model from [here](https://blendswap.com/blend/14871) to demonstrate cases where the model has slightly more complicated geometry. The llama is referred to as alpaca for the rest of the example, as alpacas are way cooler.

![alpaca](/DemoImages/1.2.0.png)

The four alpacas are (from left to right):

- Normal Alpaca: just a simple shader that assigns the given texture to the surface
- Celestial Alpaca: takes a texture and maps it using the screen-space UV (also uses emission)
- Glossy Alpaca: uses the reflection probe's cube map to achieve a reflection effect
- Fat Alpaca: introduces vertex shaders and offsets each vertex by its normal, making the alpaca fat

The code you need to understand are located in [Shaders](Shaders/).