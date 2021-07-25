# 2.0 - Compute Shaders Go Brrr

After taking a look at basic material shaders, we now move on to more interesting topics, such as carrying out calculations on the GPU via [Compute Shaders](https://docs.unity3d.com/Manual/class-ComputeShader.html).

In this chapter we are going to simulate a bunch of particles bouncing around on a plane, and render the effect as a material. The idea for this is taken from [Claire Blackshaw](https://youtu.be/qDk-WIOYUSY).

In essence, the GPU is good at processing multiple things at the same time (this is an extremely simplified depiction of GPU parallellism, but too much details at once might be confusing). This is why computer graphics, gaming and machine learning often utilize GPU computing for their superior efficiency at computing parallelable computations, such as vector math.

The short version of how GPU works is that it operates in groups of threads (called wavefront). Each wavefront carries a bunch of threads (usually either `32` or `64`), which must carry out __the exact same instructions__ (which is obviously very different from how the CPU works).